# Lightweight Skeleton

![CI](https://github.com/lucabelezal/Skeleton/workflows/CI/badge.svg)
[![codecov](https://codecov.io/gh/lucabelezal/Skeleton/branch/master/graph/badge.svg?token=f0sH9cfXWn)](https://codecov.io/gh/lucabelezal/Skeleton)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=lucabelezal_Skeleton&metric=coverage)](https://sonarcloud.io/dashboard?id=lucabelezal_Skeleton)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=lucabelezal_Skeleton&metric=security_rating)](https://sonarcloud.io/dashboard?id=lucabelezal_Skeleton)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=lucabelezal_Skeleton&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=lucabelezal_Skeleton)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=lucabelezal_Skeleton&metric=alert_status)](https://sonarcloud.io/dashboard?id=lucabelezal_Skeleton)

### Copy the files that are in the Skeleton folder

```
Source    
├───Skeleton
│   ├───UIView+Skeleton.swift
│   └───UIViewController+Skeleton
│
```

### How to use


All that inherit from UIView has `isSkeletonable` property available

```
titleLabel.isSkeletonable = true
```

To activate the Skeleton effect just call the functions in the UIViewController

```
startLoading()
stopLoading()
```

<p align="center">
  <img src="https://github.com/lucabelezal/Skeleton/blob/master/GIF/skeleton.gif" width="350"/>
</p>

