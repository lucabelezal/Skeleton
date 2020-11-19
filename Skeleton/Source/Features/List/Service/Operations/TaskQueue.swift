import Foundation

protocol TaskQueue {
    func add(_ task: AsyncTask)
    func cancel(identifier: String)
    func cancelAll()
    func execute(_ block: @escaping () -> Void)
    func task(for identifier: String) -> AsyncTask?
}

struct FlickrTaskQueue: TaskQueue {
    static let shared = FlickrTaskQueue()

    private let serialAccessQueue = OperationQueue()
    private let fetchQueue = OperationQueue()

    private init() {
        serialAccessQueue.maxConcurrentOperationCount = 1
    }

    func add(_ task: AsyncTask) {
        serialAccessQueue.addOperation {
            if self.task(for: task.identifier) == nil {
                self.fetchQueue.addOperation(task)
            }
        }
    }

    func cancel(identifier: String) {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }
            guard let op = self.task(for: identifier) else {
                return
            }
            op.cancel()
        }
    }

    func cancelAll() {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }
            self.fetchQueue.cancelAllOperations()
        }
    }

    func execute(_ block: @escaping () -> Void) {
        serialAccessQueue.addOperation {
            block()
        }
    }

    func task(for identifier: String) -> AsyncTask? {
        for case let fetchTask as AsyncTask in fetchQueue.operations
            where !fetchTask.isCancelled && fetchTask.identifier == identifier {
                return fetchTask
        }
        return nil
    }
}
