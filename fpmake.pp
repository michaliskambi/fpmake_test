program FpMake;

uses FpMkUnit;

var
  P: TPackage;
  T: TTarget;
begin
  P := Installer.AddPackage('fpmake_test');
  P.OSes := [Win32, OpenBsd, NetBsd, FreeBsd, Darwin, Linux];
  P.SourcePath.Add('code');

  T := P.Targets.AddUnit('testunit.pas');
  //T.ResourceStrings := True;
  T := P.Targets.AddProgram('test_prog.dpr');
  Installer.Run;
end.
