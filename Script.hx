import sys.FileSystem;

enum abstract Target(String) from String {
	var Flash = "flash";
	var Html5 = "html5";
}

class Script {
	static function main() {
		FileSystem.createDirectory("bin");
		Sys.setCwd("bin");

		var args = Sys.args();
		var command = args[0];
		var target = args[1];

		switch command {
			case "build":
				build(target);
			case _:
				Sys.println('unknown command $command');
		}
	}

	static function build(target:Target) {
		var args = ["run", "flixel-tools", "buildprojects", Std.string(target)];
		if (target == Html5) {
			args = args.concat(["--", "-dce", "full"]);
		}
		runCommand("haxelib", args);
	}

	static function runCommand(cmd:String, args:Array<String>):Int {
		Sys.println(cmd + " " + args.join(" "));
		return Sys.command(cmd, args);
	}
}
