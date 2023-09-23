# Drupal Drush Helper

[![CircleCI](https://circleci.com/gh/Sweetchuck/drupal-drush-helper/tree/1.x.svg?style=svg)](https://circleci.com/gh/Sweetchuck/drupal-drush-helper/?branch=1.x)
[![codecov](https://codecov.io/gh/Sweetchuck/drupal-drush-helper/branch/1.x/graph/badge.svg?token=HSF16OGPyr)](https://app.codecov.io/gh/Sweetchuck/drupal-drush-helper/branch/1.x)

@todo Description.


## PhpunitBootstrapHelper

File: `tests/bootstrap.php`

```php
<?php

declare(strict_types = 1);

use Sweetchuck\DrupalDrushHelper\PhpunitBootstrapHelper;
use Symfony\Component\Filesystem\Path;

require_once __DIR__ . '/../docroot/core/tests/bootstrap.php';

if (class_exists(PhpunitBootstrapHelper::class)) {
  (new PhpunitBootstrapHelper())
    ->populateClassLoader(
      getenv('COMPOSER') ?: 'composer.json',
      NULL,
      Path::makeRelative(dirname(__DIR__), getcwd()) ?: '.',
    );
}
```
