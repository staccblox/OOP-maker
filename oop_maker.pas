program OOP_M(input, output);
uses crt;
var
	class_name: char;
var
	attributes: int;
var
	methods: int;

begin
   writeln("(creates js class)");
   readkey;
   writeln("Class name?");
   readLn(input, class_name);
   writeln("# of attributes?");
   readLn(input, attributes);
   writeln("# of methods?");
   readLn(input, methods);
   writeln("...");
   writeln(class_name, " {");
   for i:= 1 to attributes do writeln("     attribute", i, "() {}");
   for i:= 1 to methods do writeln("     method", i, "() {}");
   writeln("}");
end. 
