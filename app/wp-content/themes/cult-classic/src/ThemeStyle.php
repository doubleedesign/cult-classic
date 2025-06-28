<?php

namespace Doubleedesign\CultClassic;

use Doubleedesign\CometCanvas\Classic\IThemeStyle;

class ThemeStyle implements IThemeStyle {

	public static function get_global_background(): string {
		return 'white';
	}

	public static function get_colours(): array {
		// Specify your site's colours here
		return array(
			'000000'       => 'Black',
			'FFFFFF'       => 'White',
			'0043CA'       => 'Primary',
			'00287A'       => 'Secondary',
			'CA0061'       => 'Accent',
			'00d2fc'       => 'Info',
			'eca133'       => 'Warning',
			'0fd301'       => 'Success',
			'a90d0d'       => 'Error',
			'11254D'       => 'Dark',
			'F0F0F2'       => 'Light'
		);
	}
}
