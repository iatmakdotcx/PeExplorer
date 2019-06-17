unit PE64;

interface

uses
  Windows, ComCtrls, PeStruts, ResConstString;

procedure DisplayDosHeader(dosHeader: PImageDosHeader; ListView: TListView);
procedure DisplayCoffHeader(pBaseAddress:Pointer; ListView: TListView);
procedure DisplayOptionalHeader(pBaseAddress: Pointer; ListView: TListView);
procedure DisplaySectionHeader(pBaseAddress: Pointer; TreeNode:TTreeNode);
procedure DisplaySectionContext(pSectionAddress: Pointer; pBaseAddress: Pointer; ListView: TListView);

function DisplayExportHeader(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
procedure DisplayExportFuncList(pBaseAddress: Pointer; ExportEntry: PImageExportDirectory; fRva:DWORD; ListView: TListView);

function DisplayImportDll(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
procedure DisplayImportFuncList(pBaseAddress: Pointer; ImportEntry: PImageImportDirectory; fRva:DWORD; ListView: TListView);

function DisplayResourceExpandingMainNode(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
procedure DisplayResourceDirectory(pBaseAddress: Pointer; ResourcefRva:DWORD;MainDirectory:PImageResourceDirectory;
   ResourceDirectory: PImageResourceDirectory; TreeNode:TTreeNode; level: Integer=0);
procedure DisplayResourceDirectoryIcon(pBaseAddress: Pointer; ResourcefRva:DWORD; TreeNode:TTreeNode);
procedure DisplayResourceDirectoryCursor(pBaseAddress: Pointer; ResourcefRva:DWORD; TreeNode:TTreeNode);
function GetResourceDataPointer(pBaseAddress: Pointer; DataEntry: PImageResourceDataEntry; ResourcefRva:DWORD):Pointer;
function GetResourceSize(DataEntry: PImageResourceDataEntry):DWORD;
procedure ExtractIconCursorLink(TreeNode:TTreeNode);

/// <summary>
/// 判断A节点是否为B节点的父节点
/// </summary>
/// <param name="A"></param>
/// <param name="B"></param>
/// <returns></returns>
function PosNodeIsParent(A:String; B:TTreeNode):boolean;


implementation

uses
  SysUtils, Unit1, math;

procedure DisplayDosHeader(dosHeader: PImageDosHeader; ListView: TListView);
begin
  ListView.Items.Clear;
  ListView.Columns[0].Caption := '地址';
  ListView.Columns[1].Caption := '值';
  ListView.Columns[2].Caption := '含意';
  with ListView.Items.Add do
  begin
    Caption := '00000000';
    SubItems.Add(Format('%.4X', [dosHeader.e_magic]));
    SubItems.Add('签名: '+Pchar(@dosHeader.e_magic));
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000002';
    SubItems.Add(Format('%.4X', [dosHeader.e_cblp]));
    SubItems.Add('额外字节');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000004';
    SubItems.Add(Format('%.4X', [dosHeader.e_cp]));
    SubItems.Add('页');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000006';
    SubItems.Add(Format('%.4X', [dosHeader.e_crlc]));
    SubItems.Add('重定位项目');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000008';
    SubItems.Add(Format('%.4X', [dosHeader.e_cparhdr]));
    SubItems.Add('标头大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000000A';
    SubItems.Add(Format('%.4X', [dosHeader.e_minalloc]));
    SubItems.Add('最小允许');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000000C';
    SubItems.Add(Format('%.4X', [dosHeader.e_maxalloc]));
    SubItems.Add('最大允许');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000000E';
    SubItems.Add(Format('%.4X', [dosHeader.e_ss]));
    SubItems.Add('初始SS');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000010';
    SubItems.Add(Format('%.4X', [dosHeader.e_sp]));
    SubItems.Add('初始SP');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000012';
    SubItems.Add(Format('%.4X', [dosHeader.e_csum]));
    SubItems.Add('效验');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000014';
    SubItems.Add(Format('%.4X', [dosHeader.e_ip]));
    SubItems.Add('初始IP');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000016';
    SubItems.Add(Format('%.4X', [dosHeader.e_cs]));
    SubItems.Add('初始CS');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000018';
    SubItems.Add(Format('%.4X', [dosHeader.e_lfarlc]));
    SubItems.Add('重定位表');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000001A';
    SubItems.Add(Format('%.4X', [dosHeader.e_ovno]));
    SubItems.Add('覆盖');
  end;

  with ListView.Items.Add do
  begin
    Caption := '0000001C';
    SubItems.Add(Format('%.4X,%.4X,%.4X,%.4X', [dosHeader.e_res[0],
                                                dosHeader.e_res[1],
                                                dosHeader.e_res[2],
                                                dosHeader.e_res[3]
                                               ]
                        ));
    SubItems.Add('保留');
  end;
  with ListView.Items.Add do
  begin
    Caption := '00000028';
    SubItems.Add(Format('%.4X', [dosHeader.e_oemid]));
    SubItems.Add('OEM标示');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000002A';
    SubItems.Add(Format('%.4X', [dosHeader.e_oeminfo]));
    SubItems.Add('OEM信息');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000001C';
    SubItems.Add(Format('%.4X,%.4X,%.4X,%.4X,%.4X,%.4X,%.4X,%.4X,%.4X,%.4X',
                                               [dosHeader.e_res2[0],
                                                dosHeader.e_res2[1],
                                                dosHeader.e_res2[2],
                                                dosHeader.e_res2[3],
                                                dosHeader.e_res2[4],
                                                dosHeader.e_res2[5],
                                                dosHeader.e_res2[6],
                                                dosHeader.e_res2[7],
                                                dosHeader.e_res2[8],
                                                dosHeader.e_res2[9]
                                               ]
                        ));
    SubItems.Add('保留2');
  end;
  with ListView.Items.Add do
  begin
    Caption := '0000004C';
    SubItems.Add(Format('%.8X', [dosHeader._lfanew]));
    SubItems.Add('Exe Header');
  end;

end;

procedure DisplayCoffHeader(pBaseAddress:Pointer; ListView: TListView);
function GetFileHeaderMachinetype(HeaderMachine:Word):string;
begin
  case HeaderMachine of
    IMAGE_FILE_MACHINE_UNKNOWN:Result:='IMAGE_FILE_MACHINE_UNKNOWN';
    IMAGE_FILE_MACHINE_AM33:Result:='IMAGE_FILE_MACHINE_AM33';
    IMAGE_FILE_MACHINE_AMD64:Result:='IMAGE_FILE_MACHINE_AMD64';
    IMAGE_FILE_MACHINE_ARM:Result:='IMAGE_FILE_MACHINE_ARM';
    IMAGE_FILE_MACHINE_ARMNT:Result:='IMAGE_FILE_MACHINE_ARMNT';
    IMAGE_FILE_MACHINE_ARM64:Result:='IMAGE_FILE_MACHINE_ARM64';
    IMAGE_FILE_MACHINE_EBC:Result:='IMAGE_FILE_MACHINE_EBC';
    IMAGE_FILE_MACHINE_I386:Result:='IMAGE_FILE_MACHINE_I386';
    IMAGE_FILE_MACHINE_IA64:Result:='IMAGE_FILE_MACHINE_IA64';
    IMAGE_FILE_MACHINE_M32R:Result:='IMAGE_FILE_MACHINE_M32R';
    IMAGE_FILE_MACHINE_MIPS16:Result:='IMAGE_FILE_MACHINE_MIPS16';
    IMAGE_FILE_MACHINE_MIPSFPU:Result:='IMAGE_FILE_MACHINE_MIPSFPU';
    IMAGE_FILE_MACHINE_MIPSFPU16:Result:='IMAGE_FILE_MACHINE_MIPSFPU16';
    IMAGE_FILE_MACHINE_POWERPC:Result:='IMAGE_FILE_MACHINE_POWERPC';
    IMAGE_FILE_MACHINE_POWERPCFP:Result:='IMAGE_FILE_MACHINE_POWERPCFP';
    IMAGE_FILE_MACHINE_R4000:Result:='IMAGE_FILE_MACHINE_R4000';
    IMAGE_FILE_MACHINE_SH3:Result:='IMAGE_FILE_MACHINE_SH3';
    IMAGE_FILE_MACHINE_SH3DSP:Result:='IMAGE_FILE_MACHINE_SH3DSP';
    IMAGE_FILE_MACHINE_SH4:Result:='IMAGE_FILE_MACHINE_SH4';
    IMAGE_FILE_MACHINE_SH5:Result:='IMAGE_FILE_MACHINE_SH5';
    IMAGE_FILE_MACHINE_THUMB:Result:='IMAGE_FILE_MACHINE_THUMB';
    IMAGE_FILE_MACHINE_WCEMIPSV2:Result:='IMAGE_FILE_MACHINE_WCEMIPSV2';
  else
    Result := '';
  end;
end;
function GetFileHeaderCharacteristicstype(HeaderCharacteristics:Word):string;
begin
  Result := '';
  if (HeaderCharacteristics and IMAGE_FILE_RELOCS_STRIPPED) > 0 then
    Result := Result + ', IMAGE_FILE_RELOCS_STRIPPED';
  if HeaderCharacteristics and IMAGE_FILE_RELOCS_STRIPPED > 0 then
    Result := Result + ', IMAGE_FILE_RELOCS_STRIPPED';
  if HeaderCharacteristics and IMAGE_FILE_EXECUTABLE_IMAGE > 0 then
    Result := Result + ', IMAGE_FILE_EXECUTABLE_IMAGE';
  if HeaderCharacteristics and IMAGE_FILE_LINE_NUMS_STRIPPED > 0 then
    Result := Result + ', IMAGE_FILE_LINE_NUMS_STRIPPED';
  if HeaderCharacteristics and IMAGE_FILE_LOCAL_SYMS_STRIPPED > 0 then
    Result := Result + ', IMAGE_FILE_LOCAL_SYMS_STRIPPED';
  if HeaderCharacteristics and IMAGE_FILE_AGGRESSIVE_WS_TRIM > 0 then
    Result := Result + ', IMAGE_FILE_AGGRESSIVE_WS_TRIM';
  if HeaderCharacteristics and IMAGE_FILE_LARGE_ADDRESS_AWARE > 0 then
    Result := Result + ', IMAGE_FILE_LARGE_ADDRESS_AWARE';
  if HeaderCharacteristics and IMAGE_FILE_Characteristics_RESERVED > 0 then
    Result := Result + ', IMAGE_FILE_Characteristics_RESERVED';
  if HeaderCharacteristics and IMAGE_FILE_BYTES_REVERSED_LO > 0 then
    Result := Result + ', IMAGE_FILE_BYTES_REVERSED_LO';
  if HeaderCharacteristics and IMAGE_FILE_32BIT_MACHINE > 0 then
    Result := Result + ', IMAGE_FILE_32BIT_MACHINE';
  if HeaderCharacteristics and IMAGE_FILE_DEBUG_STRIPPED > 0 then
    Result := Result + ', IMAGE_FILE_DEBUG_STRIPPED';
  if HeaderCharacteristics and IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP > 0 then
    Result := Result + ', IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP';
  if HeaderCharacteristics and IMAGE_FILE_NET_RUN_FROM_SWAP > 0 then
    Result := Result + ', IMAGE_FILE_NET_RUN_FROM_SWAP';
  if HeaderCharacteristics and IMAGE_FILE_SYSTEM > 0 then
    Result := Result + ', IMAGE_FILE_SYSTEM';
  if HeaderCharacteristics and IMAGE_FILE_DLL > 0 then
    Result := Result + ', IMAGE_FILE_DLL';
  if HeaderCharacteristics and IMAGE_FILE_UP_SYSTEM_ONLY > 0 then
    Result := Result + ', IMAGE_FILE_UP_SYSTEM_ONLY';
  if HeaderCharacteristics and IMAGE_FILE_BYTES_REVERSED_HI > 0 then
    Result := Result + ', IMAGE_FILE_BYTES_REVERSED_HI';
  if Length(Result)>0 then
    Delete(Result, 1, 1);
end;
var
  dosHeader: PImageDosHeader;
  NtHeaders: PImageNtHeaders;
  BaseAddress:DWORD;
begin
  dosHeader := pImageDosHeader(pBaseAddress);
  NtHeaders := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  BaseAddress := DWORD(pBaseAddress);
  
  ListView.Items.Clear;
  ListView.Columns[0].Caption := '地址';
  ListView.Columns[1].Caption := '值';
  ListView.Columns[2].Caption := '含意';
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.Signature) - BaseAddress]);
    SubItems.Add(Format('%.8X', [NtHeaders.Signature]));
    SubItems.Add('签名: '+Pchar(@NtHeaders.Signature));
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.Machine) - BaseAddress]);
    SubItems.Add(Format('%.4X', [NtHeaders.FileHeader.Machine]));
    SubItems.Add('机器: '+GetFileHeaderMachinetype(NtHeaders.FileHeader.Machine));
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.NumberOfSections) - BaseAddress]);
    SubItems.Add(Format('%.4X', [NtHeaders.FileHeader.NumberOfSections]));
    SubItems.Add('区段数');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.TimeDateStamp) - BaseAddress]);
    SubItems.Add(Format('%.8X', [NtHeaders.FileHeader.TimeDateStamp]));
    SubItems.Add('时期/日期戳');
  end;  
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.PointerToSymbolTable) - BaseAddress]);
    SubItems.Add(Format('%.8X', [NtHeaders.FileHeader.PointerToSymbolTable]));
    SubItems.Add('指示到符号表');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.NumberOfSymbols) - BaseAddress]);
    SubItems.Add(Format('%.8X', [NtHeaders.FileHeader.NumberOfSymbols]));
    SubItems.Add('符号数');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.SizeOfOptionalHeader) - BaseAddress]);
    SubItems.Add(Format('%.4X', [NtHeaders.FileHeader.SizeOfOptionalHeader]));
    SubItems.Add('可选头大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@NtHeaders.FileHeader.Characteristics) - BaseAddress]);
    SubItems.Add(Format('%.4X', [NtHeaders.FileHeader.Characteristics]));
    SubItems.Add('特性: ' + GetFileHeaderCharacteristicstype(NtHeaders.FileHeader.Characteristics));
  end;        

end;

procedure DisplayOptionalHeader(pBaseAddress:Pointer; ListView: TListView);
function GetOptionalHeaderDllCharacteristicstype(DllCharacteristics:Word):string;
begin
  Result := '';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_DYNAMIC_BASE > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_DYNAMIC_BASE';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_FORCE_INTEGRITY > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_FORCE_INTEGRITY';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_NX_COMPAT > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_NX_COMPAT';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_NO_ISOLATION > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_NO_ISOLATION';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_NO_SEH > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_NO_SEH';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_NO_BIND > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_NO_BIND';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_WDM_DRIVER > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_WDM_DRIVER';
  if DllCharacteristics and IMAGE_DLL_CHARACTERISTICS_TERMINAL_SERVER_AWARE > 0 then
    Result := Result + ',IMAGE_DLL_CHARACTERISTICS_TERMINAL_SERVER_AWARE';
  if Length(Result)>0 then
    Delete(Result, 1, 1);
end;
function GetOptionalHeaderSubsystemtype(Subsystem:Word):string;
begin
  case Subsystem of
    IMAGE_SUBSYSTEM_UNKNOWN:Result:='IMAGE_SUBSYSTEM_UNKNOWN';
    IMAGE_SUBSYSTEM_NATIVE:Result:='IMAGE_SUBSYSTEM_NATIVE';
    IMAGE_SUBSYSTEM_WINDOWS_GUI:Result:='IMAGE_SUBSYSTEM_WINDOWS_GUI';
    IMAGE_SUBSYSTEM_WINDOWS_CU:Result:='IMAGE_SUBSYSTEM_WINDOWS_CU';
    IMAGE_SUBSYSTEM_POSIX_CUI:Result:='IMAGE_SUBSYSTEM_POSIX_CUI';
    IMAGE_SUBSYSTEM_WINDOWS_CE_GUI:Result:='IMAGE_SUBSYSTEM_WINDOWS_CE_GUI';
    IMAGE_SUBSYSTEM_EFI_APPLICATION:Result:='IMAGE_SUBSYSTEM_EFI_APPLICATION';
    IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER:Result:='IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER';
    IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER:Result:='IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER';
    IMAGE_SUBSYSTEM_EFI_ROM:Result:='IMAGE_SUBSYSTEM_EFI_ROM';
    IMAGE_SUBSYSTEM_XBOX:Result:='IMAGE_SUBSYSTEM_XBOX';
  else
    Result := '';
  end;
end;
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  BaseAddress:DWORD;
  OptionalHeader: PImageOptionalHeader;
  OptionalHeader64: PImageOptionalHeader64;
  Is64Image:Boolean;
begin
  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;
  BaseAddress := UINT_PTR(pBaseAddress);

  ListView.Items.Clear;
  ListView.Columns[0].Caption := '地址';
  ListView.Columns[1].Caption := '值';
  ListView.Columns[2].Caption := '含意';
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.Magic) - BaseAddress]);
    SubItems.Add(Format('%.4X', [ntHeader.OptionalHeader.Magic]));
    SubItems.Add('Magic: 010B=PE ， 020B=PE+');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.MajorLinkerVersion) - BaseAddress]);
    SubItems.Add(Format('%.2X', [ntHeader.OptionalHeader.MajorLinkerVersion]));
    SubItems.Add('主版本号连接');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.MinorLinkerVersion) - BaseAddress]);
    SubItems.Add(Format('%.2X', [ntHeader.OptionalHeader.MinorLinkerVersion]));
    SubItems.Add('副版本号连接');
  end;

  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.SizeOfCode) - BaseAddress]);
    SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.SizeOfCode]));
    SubItems.Add('代码段大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.SizeOfInitializedData) - BaseAddress]);
    SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.SizeOfInitializedData]));
    SubItems.Add('已初始化数据大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.SizeOfUninitializedData) - BaseAddress]);
    SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.SizeOfUninitializedData]));
    SubItems.Add('未初始化数据大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.AddressOfEntryPoint) - BaseAddress]);
    SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.AddressOfEntryPoint]));
    SubItems.Add('登录指示 RVA');
  end;
  with ListView.Items.Add do      
  begin
    Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.BaseOfCode) - BaseAddress]);
    SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.BaseOfCode]));
    SubItems.Add('代码基部');
  end;
  if not Is64Image then
  begin
    OptionalHeader := @ntHeader.OptionalHeader;
    with ListView.Items.Add do
    begin
      //64位程序中没有此物
      Caption := Format('%.8X', [DWORD(@ntHeader.OptionalHeader.BaseOfData) - BaseAddress]);
      SubItems.Add(Format('%.8X', [ntHeader.OptionalHeader.BaseOfData]));
      SubItems.Add('数据基部');
    end;

    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.ImageBase) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.ImageBase]));
      SubItems.Add('映像基数');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SectionAlignment) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SectionAlignment]));
      SubItems.Add('区段队列');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.FileAlignment) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.FileAlignment]));
      SubItems.Add('文件队列');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MajorOperatingSystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MajorOperatingSystemVersion]));
      SubItems.Add('操作系统主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MinorOperatingSystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MinorOperatingSystemVersion]));
      SubItems.Add('操作系统副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MajorImageVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MajorImageVersion]));
      SubItems.Add('用户主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MinorImageVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MinorImageVersion]));
      SubItems.Add('用户副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MajorSubsystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MajorSubsystemVersion]));
      SubItems.Add('子系统主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.MinorSubsystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.MinorSubsystemVersion]));
      SubItems.Add('子系统副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.Win32VersionValue) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.Win32VersionValue]));
      SubItems.Add('已保留');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfImage) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfImage]));
      SubItems.Add('映像大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfHeaders) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfHeaders]));
      SubItems.Add('标头大小');
    end;

    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.CheckSum) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.CheckSum]));
      SubItems.Add('文件校验');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.Subsystem) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.Subsystem]));
      SubItems.Add('子系统：' + GetOptionalHeaderSubsystemtype(OptionalHeader.Subsystem));
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DllCharacteristics) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader.DllCharacteristics]));
      SubItems.Add('DLL 特性 ：' + GetOptionalHeaderDllCharacteristicstype(OptionalHeader.DllCharacteristics));
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfStackReserve) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfStackReserve]));
      SubItems.Add('堆栈已保留大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfStackCommit) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfStackCommit]));
      SubItems.Add('堆栈提交大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfHeapReserve) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfHeapReserve]));
      SubItems.Add('堆积保留大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.SizeOfHeapCommit) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.SizeOfHeapCommit]));
      SubItems.Add('堆积提交大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.LoaderFlags) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.LoaderFlags]));
      SubItems.Add('加载器标记(废弃)');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.NumberOfRvaAndSizes) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.NumberOfRvaAndSizes]));
      SubItems.Add('数据目录数');
    end;
    //目录
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress]));
      SubItems.Add('输出表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size]));
      SubItems.Add('&大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress]));
      SubItems.Add('输入表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress]));
      SubItems.Add('资源表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].VirtualAddress]));
      SubItems.Add('异常表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].VirtualAddress]));
      SubItems.Add('安全表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress]));
      SubItems.Add('基部重定位表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress]));
      SubItems.Add('调试数据地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].VirtualAddress]));
      SubItems.Add('版权数据地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].VirtualAddress]));
      SubItems.Add('全局Ftr');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress]));
      SubItems.Add('TLS表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].VirtualAddress]));
      SubItems.Add('载入配置表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].Size]));
      SubItems.Add('  &大小');
    end;
  end else begin //64位程序
    OptionalHeader64 := @ntHeader.OptionalHeader;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.ImageBase) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.ImageBase]));
      SubItems.Add('映像基数');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SectionAlignment) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.SectionAlignment]));
      SubItems.Add('区段队列');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.FileAlignment) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.FileAlignment]));
      SubItems.Add('文件队列');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MajorOperatingSystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MajorOperatingSystemVersion]));
      SubItems.Add('操作系统主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MinorOperatingSystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MinorOperatingSystemVersion]));
      SubItems.Add('操作系统副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MajorImageVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MajorImageVersion]));
      SubItems.Add('用户主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MinorImageVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MinorImageVersion]));
      SubItems.Add('用户副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MajorSubsystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MajorSubsystemVersion]));
      SubItems.Add('子系统主版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.MinorSubsystemVersion) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.MinorSubsystemVersion]));
      SubItems.Add('子系统副版本');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.Win32VersionValue) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.Win32VersionValue]));
      SubItems.Add('已保留');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfImage) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.SizeOfImage]));
      SubItems.Add('映像大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfHeaders) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.SizeOfHeaders]));
      SubItems.Add('标头大小');
    end;

    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.CheckSum) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.CheckSum]));
      SubItems.Add('文件校验');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.Subsystem) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.Subsystem]));
      SubItems.Add('子系统：' + GetOptionalHeaderSubsystemtype(OptionalHeader64.Subsystem));
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DllCharacteristics) - BaseAddress]);
      SubItems.Add(Format('%.4X', [OptionalHeader64.DllCharacteristics]));
      SubItems.Add('DLL 特性 ：' + GetOptionalHeaderDllCharacteristicstype(OptionalHeader64.DllCharacteristics));
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfStackReserve) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.SizeOfStackReserve]));
      SubItems.Add('堆栈已保留大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfStackCommit) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.SizeOfStackCommit]));
      SubItems.Add('堆栈提交大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfHeapReserve) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.SizeOfHeapReserve]));
      SubItems.Add('堆积保留大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.SizeOfHeapCommit) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.SizeOfHeapCommit]));
      SubItems.Add('堆积提交大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.LoaderFlags) - BaseAddress]);
      SubItems.Add(Format('%.16X', [OptionalHeader64.LoaderFlags]));
      SubItems.Add('加载器标记(废弃)');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.NumberOfRvaAndSizes) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.NumberOfRvaAndSizes]));
      SubItems.Add('数据目录数');
    end;
    //目录
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress]));
      SubItems.Add('输出表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress]));
      SubItems.Add('输入表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress]));
      SubItems.Add('资源表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].VirtualAddress]));
      SubItems.Add('异常表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].VirtualAddress]));
      SubItems.Add('安全表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_SECURITY].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].VirtualAddress]));
      SubItems.Add('基部重定位表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].VirtualAddress]));
      SubItems.Add('调试数据地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_DEBUG].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].VirtualAddress]));
      SubItems.Add('版权数据地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_COPYRIGHT].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].VirtualAddress]));
      SubItems.Add('全局Ftr');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_GLOBALPTR].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].VirtualAddress]));
      SubItems.Add('TLS表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS].Size]));
      SubItems.Add('  &大小');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].VirtualAddress) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].VirtualAddress]));
      SubItems.Add('载入配置表地址');
    end;
    with ListView.Items.Add do
    begin
      Caption := Format('%.8X', [DWORD(@OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].Size) - BaseAddress]);
      SubItems.Add(Format('%.8X', [OptionalHeader64.DataDirectory[IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG].Size]));
      SubItems.Add('  &大小');
    end;
  end;
end;

procedure DisplaySectionHeader(pBaseAddress: Pointer; TreeNode:TTreeNode);
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  sectionHeader: PImageSectionHeader;
  i: integer;
  sectionName:string;
begin
  //定位到第一个节的地址
  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  sectionHeader := PImageSectionHeader(LongInt(@ntHeader.OptionalHeader) + ntHeader.FileHeader.SizeOfOptionalHeader);
  for i := 0 to ntHeader.FileHeader.NumberOfSections - 1 do
  begin
    sectionName := Copy(PAnsiChar(@sectionHeader.Name), 1, 8);
    (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, sectionName, sectionHeader);
    Inc(sectionHeader);
  end;
end;

procedure DisplaySectionContext(pSectionAddress: Pointer; pBaseAddress: Pointer; ListView: TListView);
function GetSectionFlagsComment(sfCharacteristics:DWord):string;
begin
  Result := '';
  if sfCharacteristics and IMAGE_SCN_TYPE_NO_PAD > 0 then
    Result := Result + ',  IMAGE_SCN_TYPE_NO_PAD';
  if sfCharacteristics and IMAGE_SCN_CNT_CODE > 0 then
    Result := Result + ',  (包含可执行代码)IMAGE_SCN_CNT_CODE';
  if sfCharacteristics and IMAGE_SCN_CNT_INITIALIZED_DATA > 0 then
    Result := Result + ',  (已经初始化数据)IMAGE_SCN_CNT_INITIALIZED_DATA';
  if sfCharacteristics and IMAGE_SCN_CNT_UNINITIALIZED_DATA > 0 then
    Result := Result + ',  (未经初始化数据)IMAGE_SCN_CNT_UNINITIALIZED_DATA';
  if sfCharacteristics and IMAGE_SCN_LNK_OTHER > 0 then
    Result := Result + ',  (保留)IMAGE_SCN_LNK_OTHER';
  if sfCharacteristics and IMAGE_SCN_LNK_INFO > 0 then
    Result := Result + ',  (包含连接信息)IMAGE_SCN_LNK_INFO';
  if sfCharacteristics and IMAGE_SCN_LNK_REMOVE > 0 then
    Result := Result + ',  (不可成为镜像的一部分)IMAGE_SCN_LNK_REMOVE';
  if sfCharacteristics and IMAGE_SCN_LNK_COMDAT > 0 then
    Result := Result + ',  (包含COMDAT数据)IMAGE_SCN_LNK_COMDAT';
  if sfCharacteristics and IMAGE_SCN_GPREL > 0 then
    Result := Result + ',  IMAGE_SCN_GPREL';
  if sfCharacteristics and IMAGE_SCN_MEM_PURGEABLE > 0 then
    Result := Result + ',  IMAGE_SCN_MEM_PURGEABLE';
  if sfCharacteristics and IMAGE_SCN_MEM_16BIT > 0 then
    Result := Result + ',  IMAGE_SCN_MEM_16BIT';
  if sfCharacteristics and IMAGE_SCN_MEM_LOCKED > 0 then
    Result := Result + ',  IMAGE_SCN_MEM_LOCKED';
  if sfCharacteristics and IMAGE_SCN_MEM_PRELOAD > 0 then
    Result := Result + ',  IMAGE_SCN_MEM_PRELOAD';
  if sfCharacteristics and IMAGE_SCN_ALIGN_1BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_1BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_2BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_2BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_4BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_4BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_8BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_8BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_16BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_16BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_32BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_32BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_64BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_64BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_128BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_128BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_256BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_256BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_512BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_512BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_1024BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_1024BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_2048BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_2048BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_4096BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_4096BYTES';
  if sfCharacteristics and IMAGE_SCN_ALIGN_8192BYTES > 0 then
    Result := Result + ',  IMAGE_SCN_ALIGN_8192BYTES';
  if sfCharacteristics and IMAGE_SCN_LNK_NRELOC_OVFL > 0 then
    Result := Result + ',  (包含扩展重定向)IMAGE_SCN_LNK_NRELOC_OVFL';
  if sfCharacteristics and IMAGE_SCN_MEM_DISCARDABLE > 0 then
    Result := Result + ',  (可废弃)IMAGE_SCN_MEM_DISCARDABLE';
  if sfCharacteristics and IMAGE_SCN_MEM_NOT_CACHED > 0 then
    Result := Result + ',  (不可隐藏)IMAGE_SCN_MEM_NOT_CACHED';
  if sfCharacteristics and IMAGE_SCN_MEM_NOT_PAGED > 0 then
    Result := Result + ',  (不可分页)IMAGE_SCN_MEM_NOT_PAGED';
  if sfCharacteristics and IMAGE_SCN_MEM_SHARED > 0 then
    Result := Result + ',  (可共享)IMAGE_SCN_MEM_SHARED';
  if sfCharacteristics and IMAGE_SCN_MEM_EXECUTE > 0 then
    Result := Result + ',  (可执行)IMAGE_SCN_MEM_EXECUTE';
  if sfCharacteristics and IMAGE_SCN_MEM_READ > 0 then
    Result := Result + ',  (可读)IMAGE_SCN_MEM_READ';
  if sfCharacteristics and IMAGE_SCN_MEM_WRITE > 0 then
    Result := Result + ',  (可写)IMAGE_SCN_MEM_WRITE';

  if Length(Result)>0 then
    Delete(Result, 1, 1);
end;
var
  sectionHeader: PImageSectionHeader;
  BaseAddress:DWORD;
begin
  sectionHeader := pSectionAddress;
  BaseAddress := DWORD(pBaseAddress);
  
  ListView.Items.Clear;
  ListView.Columns[0].Caption := '地址';
  ListView.Columns[1].Caption := '值';
  ListView.Columns[2].Caption := '含意';
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.Name) - BaseAddress]);
    SubItems.Add(Format('%s', [Copy(PChar(@sectionHeader.Name), 1, 8)]));
    SubItems.Add('区段名');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.Misc.VirtualSize) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.Misc.VirtualSize]));
    SubItems.Add('虚拟大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.VirtualAddress) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.VirtualAddress]));
    SubItems.Add('RVA/偏移');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.SizeOfRawData) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.SizeOfRawData]));
    SubItems.Add('Raw数据大小');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.PointerToRawData) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.PointerToRawData]));
    SubItems.Add('指向Raw数据');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.PointerToRelocations) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.PointerToRelocations]));
    SubItems.Add('指向重定位');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.PointerToLinenumbers) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.PointerToLinenumbers]));
    SubItems.Add('重定向行数');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.NumberOfRelocations) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.NumberOfRelocations]));
    SubItems.Add('重定位号');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.NumberOfLinenumbers) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.NumberOfLinenumbers]));
    SubItems.Add('行数号');
  end;
  with ListView.Items.Add do
  begin
    Caption := Format('%.8X', [DWORD(@sectionHeader.Characteristics) - BaseAddress]);
    SubItems.Add(Format('%.8X', [sectionHeader.Characteristics]));
    SubItems.Add('区段标记: '+ GetSectionFlagsComment(sectionHeader.Characteristics));
  end;
end;

function DisplayExportHeader(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  sectionHeader: PImageSectionHeader;
  ExportEntry: PImageExportDirectory;
  Is64Image:Boolean;
  Rva: DWORD;
  fRva: DWORD;
  I:integer;
  dllname:string;
begin
  Result := $FFFFFFFF;
  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;
  if not Is64Image then
  begin
    Rva :=PImageOptionalHeader(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;
  end else begin
    Rva :=PImageOptionalHeader64(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;
  end;
  if Rva = 0 then Exit; //没有导出表
  //定位到第一个节的地址
  sectionHeader := PImageSectionHeader(LongInt(@ntHeader.OptionalHeader) + ntHeader.FileHeader.SizeOfOptionalHeader);
  for i := 0 to ntHeader.FileHeader.NumberOfSections - 1 do
  begin
    //IMAGE_DIRECTORY_ENTRY_IMPORT，引入表，检查rva是否落在节内
    if (Rva >= LongInt(sectionHeader.VirtualAddress)) and
      (Rva < LongInt(sectionHeader.VirtualAddress + sectionHeader.Misc.VirtualSize)) then
    begin
      Break;
    end;
    //增加SizeOf(TImageSectionHeader)字节数，指向下一个节
    Inc(sectionHeader);
  end;
  //虚拟地址在段 内的偏移
  Rva := Rva - sectionHeader.VirtualAddress;
  //计算虚拟地址和物理地址的差，便于地址转换
  fRva := sectionHeader.VirtualAddress - sectionHeader.PointerToRawData;
  //导出表地址 = 文件内存 + 段物理地址 + 导出表在段内偏移
  ExportEntry := PImageExportDirectory(LongInt(pBaseAddress) + sectionHeader.PointerToRawData + Rva);
  dllname := PChar(LongInt(pBaseAddress) + ExportEntry.Name - fRva);
  (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, dllname, ExportEntry);
  Result := fRva;
end;

procedure DisplayExportFuncList(pBaseAddress: Pointer; ExportEntry: PImageExportDirectory; fRva:DWORD; ListView: TListView);
var
  I:integer;
  funcAddr, ordAddr, fNameAddr:Dword;
  afuncAddr: DWORD;
  afuncAddrOffset: DWORD;
  afuncOrd: word;
  afuncName:string;
begin
  // - fRva = (RVA --> Raw)
  funcAddr := LongInt(pBaseAddress) + LongInt(ExportEntry.AddressOfFunctions) - fRva;
  fNameAddr := LongInt(pBaseAddress) + LongInt(ExportEntry.AddressOfNames) - fRva;
  ordAddr := LongInt(pBaseAddress) + LongInt(ExportEntry.AddressOfNameOrdinals) - fRva;
  ListView.Items.Clear;
  ListView.Columns[0].Caption := '序号';
  ListView.Columns[1].Caption := '地址';
  ListView.Columns[2].Caption := '名字';
  ListView.Columns[3].Caption := 'funcAddrOffset';
  for I := 0 to ExportEntry.NumberOfNames - 1 do
  begin
    afuncOrd := PWORD(ordAddr + I * Sizeof(WORD))^;
    afuncAddr := PDWORD(funcAddr + afuncOrd * Sizeof(DWORD))^;
    afuncAddrOffset := funcAddr + afuncOrd * Sizeof(DWORD) - LongInt(pBaseAddress) ;
    afuncName :=  PChar(LongInt(pBaseAddress) + PDWORD(fNameAddr + I * Sizeof(DWORD))^ - fRva);
    //要加上ordbase
    afuncOrd := afuncOrd + ExportEntry.Base;
    ListView.items.BeginUpdate;
    with ListView.Items.Add do
    begin
      Caption := Format('%.4X', [afuncOrd]);
      SubItems.Add(Format('%.8X', [afuncAddr]));
      SubItems.Add(afuncName);
      SubItems.Add(Format('%.8X', [afuncAddrOffset]));
    end;
    ListView.items.EndUpdate;
  end;
end;

function DisplayImportDll(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  sectionHeader: PImageSectionHeader;
  ImportEntry: PImageImportDirectory;
  Is64Image:Boolean;
  Rva: DWORD;
  fRva: DWORD;
  I:integer;
  dllname:string;
begin
  Result := $FFFFFFFF;
  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;
  if not Is64Image then
  begin
    Rva :=PImageOptionalHeader(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
  end else begin
    Rva :=PImageOptionalHeader64(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
  end;
  if Rva = 0 then Exit; //没有导入表
  //定位到第一个节的地址
  sectionHeader := PImageSectionHeader(LongInt(@ntHeader.OptionalHeader) + ntHeader.FileHeader.SizeOfOptionalHeader);
  for i := 0 to ntHeader.FileHeader.NumberOfSections - 1 do
  begin
    //IMAGE_DIRECTORY_ENTRY_IMPORT，引入表，检查rva是否落在节内
    if (Rva >= LongInt(sectionHeader.VirtualAddress)) and
      (Rva < LongInt(sectionHeader.VirtualAddress + sectionHeader.Misc.VirtualSize)) then
    begin
      Break;
    end;
    //增加SizeOf(TImageSectionHeader)字节数，指向下一个节
    Inc(sectionHeader);
  end;
  //虚拟地址在段 内的偏移
  Rva := Rva - sectionHeader.VirtualAddress;
  //计算虚拟地址和物理地址的差，便于地址转换
  fRva := sectionHeader.VirtualAddress - sectionHeader.PointerToRawData;
  //导入表地址 = 文件内存 + 段物理地址 + 导出表在段内偏移
  ImportEntry := PImageImportDirectory(LongInt(pBaseAddress) + sectionHeader.PointerToRawData + Rva);
  while ImportEntry.Name<>0 do
  begin
    dllname := PChar(LongInt(pBaseAddress) + ImportEntry.Name - fRva);
    (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, dllname,
        Pointer(LongInt(pBaseAddress) + ImportEntry.OriginalFirstThunk - fRva));
    inc(ImportEntry);
  end;
  Result := fRva;
end;

procedure DisplayImportFuncList(pBaseAddress: Pointer; ImportEntry: PImageImportDirectory; fRva:DWORD; ListView: TListView);
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  iib:PImageImportByName;
  funcAddr:PDword;
  funcAddr64:PQword;
  Is64Image:Boolean;
begin
  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;

  ListView.Items.Clear;
  ListView.Columns[0].Caption := '顺序';
  ListView.Columns[1].Caption := '';
  ListView.Columns[2].Caption := '名字';

  if not Is64Image then
  begin
    funcAddr := Pointer(ImportEntry);
    while funcAddr^ <> 0 do
    begin
      iib := Pointer(LongInt(pBaseAddress) + funcAddr^ - fRva);
      with ListView.Items.Add do
      begin
        Caption := Format('%.4X', [iib.Hint]);
        SubItems.Add('');
        SubItems.Add(Pchar(@iib.Name));
      end;
      inc(funcAddr);
    end;
  end else begin
    funcAddr64 := Pointer(ImportEntry);
    while funcAddr64^ <> 0 do
    begin
      iib := Pointer(LongInt(pBaseAddress) + funcAddr64^ - fRva);
      with ListView.Items.Add do
      begin
        Caption := Format('%.4X', [iib.Hint]);
        SubItems.Add('');
        SubItems.Add(Pchar(@iib.Name));
      end;
      inc(funcAddr64);
    end;
  end;
end;

function DisplayResourceExpandingMainNode(pBaseAddress: Pointer; TreeNode:TTreeNode):DWORD;
var
  dosHeader: PImageDosHeader;
  ntHeader: PImageNtHeaders;
  sectionHeader: PImageSectionHeader;
  ResourceDirectory:PImageResourceDirectory;
  Is64Image:Boolean;
  Rva: DWORD;
  fRva: DWORD;
  I:integer;
  subItem,subItem2:TTreeNode;
  ResName:string;
  ResAddr:DWORD;
  IRDS:PImageResourceDirStringU;
begin
  subItem := TreeNode.getFirstChild;
  while Assigned(subItem) do
  begin
    subItem2 := subItem;
    subItem := TreeNode.GetNextChild(subItem2);
    subItem2.Delete;
  end;

  dosHeader := pImageDosHeader(pBaseAddress);
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;
  if not Is64Image then
  begin
    Rva :=PImageOptionalHeader(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
  end else begin
    Rva :=PImageOptionalHeader64(@ntHeader.OptionalHeader).DataDirectory[IMAGE_DIRECTORY_ENTRY_RESOURCE].VirtualAddress;
  end;
  if Rva = 0 then Exit; //没有导入表
  //定位到第一个节的地址
  sectionHeader := PImageSectionHeader(LongInt(@ntHeader.OptionalHeader) + ntHeader.FileHeader.SizeOfOptionalHeader);
  for i := 0 to ntHeader.FileHeader.NumberOfSections - 1 do
  begin
    //IMAGE_DIRECTORY_ENTRY_IMPORT，引入表，检查rva是否落在节内
    if (Rva >= LongInt(sectionHeader.VirtualAddress)) and
      (Rva < LongInt(sectionHeader.VirtualAddress + sectionHeader.Misc.VirtualSize)) then
    begin
      Break;
    end;
    //增加SizeOf(TImageSectionHeader)字节数，指向下一个节
    Inc(sectionHeader);
  end;
  Rva := Rva - sectionHeader.VirtualAddress;
  fRva := sectionHeader.VirtualAddress - sectionHeader.PointerToRawData;
  ResourceDirectory := PImageResourceDirectory(LongInt(pBaseAddress) + sectionHeader.PointerToRawData + Rva);
  DisplayResourceDirectory(pBaseAddress, fRva, ResourceDirectory, ResourceDirectory, TreeNode);
  result := fRva;
end;

procedure DisplayResourceDirectory(pBaseAddress: Pointer; ResourcefRva:DWORD;MainDirectory:PImageResourceDirectory; ResourceDirectory: PImageResourceDirectory; TreeNode:TTreeNode; level: Integer=0);
var
  I:Integer;
  ResName:string;
  ResAddr:DWORD;
  IRDS:PImageResourceDirStringU;
  subResourceDirectory: PImageResourceDirectory;
  Node:TTreeNode;
  buf:array[0..127] of Char;

  HasChild:boolean;
begin
  for I := 0 to ResourceDirectory.NumberOfNamedEntries + ResourceDirectory.NumberOfIdEntries - 1 do
  begin
    HasChild := True;
    ResName := '';
    if ResourceDirectory.DirectoryEntry[I].Name and $80000000 >1 then //自定义资源名
    begin
      ResAddr := ResourceDirectory.DirectoryEntry[I].Name and $7FFFFFFF;
      IRDS := PImageResourceDirStringU(LongInt(MainDirectory) + ResAddr);
      ResName := Copy(PWideChar(@IRDS.NameString), 1, IRDS.Length);
    end else begin   //预定义资源名id
      if (ResourceDirectory.DirectoryEntry[I].Name < Length(ResourceTypeName)) and
         (level = 0) then   //只有第一层才使用资源名
      begin
        ResName := ResourceTypeName[ResourceType(ResourceDirectory.DirectoryEntry[I].Name)];
      end else begin
        ZeroMemory(@buf[0], Length(buf));
        if (level <> 1) and   // 第二层 肯定不是语言，直接显示编号
          (VerLanguageNameA(ResourceDirectory.DirectoryEntry[I].Name, buf, Length(buf))<> 0) then
        begin
          ResName := buf;
        end else begin
          ResName := inttostr(ResourceDirectory.DirectoryEntry[I].Name);
        end;
      end;
    end;
    ResAddr := ResourceDirectory.DirectoryEntry[I].OffsetToData and $7FFFFFFF;
    subResourceDirectory := PImageResourceDirectory(LongInt(MainDirectory) + ResAddr);
    Node := (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, ResName, TreeNode.Data);
    if ResourceDirectory.DirectoryEntry[I].OffsetToData and $80000000 > 1 then //目录
    begin
      if (level > 0) and
         (subResourceDirectory.NumberOfNamedEntries = 0) and
         (subResourceDirectory.NumberOfIdEntries = 1) then
      begin
        ZeroMemory(@buf[0], Length(buf));
        if VerLanguageNameA(subResourceDirectory.DirectoryEntry[0].Name, buf, Length(buf)) <> 0 then
        begin
          //如果只有一个资源输出，且是语言的话，就跳过这一层
          ResAddr := subResourceDirectory.DirectoryEntry[0].OffsetToData and $7FFFFFFF;
          Node.Data := PImageResourceDirectory(LongInt(MainDirectory) + ResAddr);
          HasChild := False;
        end
      end;
      if HasChild then
        DisplayResourceDirectory(pBaseAddress, ResourcefRva, MainDirectory, subResourceDirectory, Node, level + 1);
    end else begin
      Node.Data := subResourceDirectory;
      HasChild := False;
    end;
      
    if not HasChild then    //当前节点没有子节点，或子节点只有一个语言包节点
    begin
      if PosNodeIsParent(ResourceTypeName[rtIcon], Node) then //图标
      begin
        DisplayResourceDirectoryIcon(pBaseAddress, ResourcefRva, Node);
      end else if PosNodeIsParent(ResourceTypeName[rtCursor], Node) then //光标
      begin
        DisplayResourceDirectoryCursor(pBaseAddress, ResourcefRva, Node);
      end;
    end;

  end;
end;

procedure DisplayResourceDirectoryIcon(pBaseAddress: Pointer; ResourcefRva:DWORD; TreeNode:TTreeNode);
var
  IconData: PIconResInfo;  
  I:Integer;
  CNodeCaption:string;
  Node:TTreeNode;

  ImageResourceDataEntry:PImageResourceDataEntry;
  buf:Pointer;
begin
  ImageResourceDataEntry := TreeNode.Data;
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  IconData := PIconResInfo(DWORD(buf) + SizeOf(TNEWHEADER ));
  for I := 0 to PNEWHEADER(buf)^.ResCount - 1 do
  begin
    CNodeCaption := Format('%d: %d*%d, %d位', [IconData.wNameOrdinal,
                       IconData.bWidth, IconData.bHeight,
                       IconData.wBitCount
                    ]);
    Node := (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, CNodeCaption, Pointer(TREE_RESOURCE_NEEDLINK_ICON));
    Inc(IconData);
  end;
end;
procedure DisplayResourceDirectoryCursor(pBaseAddress: Pointer; ResourcefRva:DWORD; TreeNode:TTreeNode);
var
  CursorData: PCursorResInfo;
  I:Integer;
  CNodeCaption:string;
  Node:TTreeNode;

  ImageResourceDataEntry:PImageResourceDataEntry;
  buf:Pointer;
begin
  ImageResourceDataEntry := TreeNode.Data;
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  CursorData := PCursorResInfo(DWORD(buf) + SizeOf(TNEWHEADER ));
  for I := 0 to PNEWHEADER(buf)^.ResCount - 1 do
  begin
    CNodeCaption := Format('%d: %d*%d, %d位', [CursorData.wNameOrdinal,
                       CursorData.wWidth, CursorData.wWidth,
                       CursorData.wBitCount
                    ]);
    Node := (TreeNode.TreeView as TTreeView).Items.AddChildObject(TreeNode, CNodeCaption, Pointer(TREE_RESOURCE_NEEDLINK_Cursor));
    Inc(CursorData);
  end;
end;

function GetResourceSize(DataEntry: PImageResourceDataEntry):DWORD;
begin
  Result := DataEntry.Size;
end;

function GetResourceDataPointer(pBaseAddress: Pointer; DataEntry: PImageResourceDataEntry; ResourcefRva:DWORD):Pointer;
begin
  Result := Pointer(LongInt(pBaseAddress) + DataEntry.Data - ResourcefRva);
end;

procedure ExtractIconCursorLink(TreeNode:TTreeNode);
function FindTreeNode(Node:TTreeNode;NodeCaption:string):TTreeNode;
var
  t:TTreeNode;
begin
  t := Node.getFirstChild;
  while Assigned(t) do
  begin
    if t.Text = NodeCaption then
    begin
      result := t;
      exit;
    end;
    t := Node.GetNextChild(t);
  end;
  result := nil;
end;
var
  TreeView : TTreeView;
  CursorNode, IconNode:TTreeNode;
  tmpNode :TTreeNode;
  tmpStr :String;
  I: Integer;
begin
  if not TreeNode.HasChildren then exit;
  IconNode:=FindTreeNode(TreeNode, ResourceTypeName[rtIconEntry]);
  CursorNode:=FindTreeNode(TreeNode, ResourceTypeName[rtCursorEntry]);


  TreeView := (TreeNode.TreeView as TTreeView);
  for I := 0 to TreeView.Items.Count - 1 do
  begin
    if DWORD(TreeView.Items[i].Data) = TREE_RESOURCE_NEEDLINK_ICON then
    begin
      tmpStr := copy(TreeView.Items[i].Text,1,pos(':',TreeView.Items[i].Text) - 1);
      tmpNode := FindTreeNode(IconNode, tmpStr);
      if Assigned(tmpNode) then
      begin
        TreeView.Items[i].Data := tmpNode.Data;
      end;
    end;
    if DWORD(TreeView.Items[i].Data) = TREE_RESOURCE_NEEDLINK_Cursor then
    begin
      tmpStr := copy(TreeView.Items[i].Text,1,pos(':',TreeView.Items[i].Text) - 1);
      tmpNode := FindTreeNode(CursorNode, tmpStr);
      if Assigned(tmpNode) then
      begin
        TreeView.Items[i].Data := tmpNode.Data;
      end;
    end;    
  end;

  if CursorNode<>nil then
  begin
    CursorNode.DeleteChildren;
    CursorNode.Delete;
  end;
  if IconNode<>nil then
  begin
    IconNode.DeleteChildren;
    IconNode.Delete;
  end;

end;

function PosNodeIsParent(A:String; B:TTreeNode):boolean;
begin
  Result := False;
  while Assigned(B) do
  begin
    if B.Text = A then
    begin
      Result := True;
      Exit;
    end;
    if not Assigned(B.Parent) then
     break;
    B := B.Parent;
  end;
end;



end.
