# Cult Classic

Yet another website blueprint - this time for ClassicPress and [Comet Components](https://cometcomponents.io), equipped with [ACF Dynamic Preview](https://github.com/doubleedesign/acf-dynamic-preview) functionality and various other enhancements via purpose-developed plugins.

### Why?

Because sometimes the block editor is a fucking pain in the ass for custom design and/or proper data structures[^1], you just want to go back to when the admin looked consistent on every screen, you wonder what the fuck was wrong with writing basic HTML sprinkled with PHP in basic template part files to output your shit on the page without a build step or any such nonsense, and your client doesn't give a shit anyway as long as it works nicely. Working nicely like it's 2018 but with newer PHP/CSS/JS features and stuff is _fine_, even _good_.

[^1]: Yes, I know storing content in postmeta as ACF flexible content does is not a great data structure. But extensive use of custom post types, taxonomies, custom fields for data that should have a field in the database, and the PHP template hierarchy is.

### How?

This repo includes a base theme and the Composer configuration to install [ClassicPress](https://www.classicpress.net/) and common plugins that I use via Composer, including a bunch of my own designed specifically for this workflow. The only thing it doesn't include is the ability to auto-install plugins that require a commercial licence, notably [ACF Pro](https://www.advancedcustomfields.com/pro/) which is essential.

You can configure it for WordPress if you prefer by updating `composer.json` in your project and installing the Classic Editor plugin (or disabling Gutenberg on the relevant, if not all, post types via custom code).

---

## Usage

Cult Classic is intended for use by developers. It requires some setup in a local development environment before it will form a functioning site, which requires a reasonable level of comfort with using command-line tools such as Composer, Git, and PowerShell. Developing themes with it requires familiarity and comfort working directly with HTML, PHP, SCSS, and some JS code.

The below guides, included scripts, and included config files are intended for Windows (PowerShell) and PhpStorm users. Adjust as needed for your environment.

## Quick start

### Prerequisites
- Laravel Herd Pro installed locally (or an alternative local web server that provides PHP and MySQL)
- PHP and Composer available on the command line (should be taken care of by Herd)

### Initial setup for a new project
1. Fork this repository, giving it a new name to suit your project
2. Clone your fork locally
3. Update `composer.json` in the project root with your project name, author details, and any changes to dependencies you require
4. Rename the child theme directory, update the header in `style.scss` with all the relevant details, and update the namespace in the theme's PHP classes
5. Update references to the `cult-classic` theme in `composer.json` to the name of your renamed theme directory
6. Run `./setup.ps1` from the root directory to automatically configure the local web server, set up the database, and install/update dependencies
7. Download [ACF Pro](https://www.advancedcustomfields.com/pro/) and put it in `app/wp-content/plugins`
8. Go to `yoursite.test` and follow the ClassicPress install steps
9. In this README file, delete everything above this line and replace it with your project's description and details.

---
## Local development

### Prerequisites
- Project repo set up (named for the project, theme renamed, namespace updated, Composer file updated, database dump available, etc.)
- Laravel Herd Pro installed locally (or an alternative local web server that provides PHP and MySQL)
- PHP, Composer, and MySQL available on the command line (should be taken care of by Herd)
- Laravel Pint installed globally and configured in PhpStorm for the project (for linting and formatting)
```powershell
composer global require laravel/pint
```
- Symfony VarDumper installed globally (for debugging)
```powershell
composer global require symfony/var-dumper
```
- Sass installed, available on the command line, and configured in PhpStorm for the project
```powershell
choco install sass
```

### Setup & refresh

The setup script can be reused after initial setup when moving between machines, updating dependencies, updating the local database, etc.

In PowerShell, run:
```powershell
./setup.ps1
```

Or manually:
1. From the project root, install dependencies using `composer install` (this will also run a post-install script to ensure dependencies and autoloading for the installed dependencies are also up-to-date)
2. Import the latest database into Herd's MySQL instance
3. From the `app` directory, run `herd link your-site` and `herd secure`. 

### Packup 

When done with some dev work, you can automatically commit all changes and export a copy of the database and put it in the `sql` directory by running:

```powershell
./packup.ps1
```

This is "packing up for the day", as opposed to a "teardown" script which would delete the database and Herd config. This is so work is backed up, can be picked up on another machine, etc.

---
## Theme development

Details to come.
