program FuncExporter;

uses
  FastMM4 in 'H:\Delphi\FastMM\FastMM4.pas',
  FastMM4Messages in 'H:\Delphi\FastMM\FastMM4Messages.pas',
  Forms,
  Unit1 in 'Unit1.pas' {FMain},
  PeStruts in 'PeStruts.pas',
  PE64 in 'PE64.pas',
  PE32 in 'PE32.pas',
  Memory_Common in 'H:\Delphi\通用的自定义单元\Memory_Common.pas',
  ResConstString in 'ResConstString.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
