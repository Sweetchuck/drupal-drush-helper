<?php

declare(strict_types = 1);

namespace Sweetchuck\DrupalDrushHelper\Tests\Unit;

use Composer\Autoload\ClassLoader;
use Sweetchuck\DrupalDrushHelper\PhpunitBootstrapHelper;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Filesystem\Path;

/**
 * @covers \Sweetchuck\DrupalDrushHelper\PhpunitBootstrapHelper
 */
class PhpunitBootstrapHelperTest extends TestCase
{

    /**
     * @throws \PHPUnit\Framework\MockObject\Exception
     */
    public function testPopulateClassLoader(): void
    {
        $rootDir = Path::join('tests', 'fixtures', 'project_01');
        $composerFileName = 'composer.json';
        $classLoader = $this->createMock(ClassLoader::class);
        $classLoader
            ->expects(static::exactly(8))
            ->method('addPsr4')
            ->willReturnMap([
                ['Drupal\\a\\Commands\\', "$rootDir/drush/Commands/contrib/a/Commands/a", null],
                ['Drupal\\a\\Generators\\', "$rootDir/drush/Commands/contrib/a/Generators/a", null],
                ['Drupal\\a\\', "$rootDir/drush/Commands/contrib/a/src", null],
                ['Drupal\\Tests\\a\\', "$rootDir/drush/Commands/contrib/a/tests/src", null],
                ['Drupal\\b\\Commands\\', "$rootDir/drush/Commands/contrib/b/Commands/b", null],
                ['Drupal\\b\\Generators\\', "$rootDir/drush/Commands/contrib/b/Generators/b", null],
                ['Drupal\\b\\', "$rootDir/drush/Commands/contrib/b/src", null],
                ['Drupal\\Tests\\b\\', "$rootDir/drush/Commands/contrib/b/tests/src", null],
            ]);
        $helper = new PhpunitBootstrapHelper();
        $helper->populateClassLoader(
            $composerFileName,
            $classLoader,
            $rootDir,
        );
    }
}
