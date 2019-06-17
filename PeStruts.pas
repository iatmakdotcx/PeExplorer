//  Resource File Formats
//  https://msdn.microsoft.com/en-us/library/ms648007(VS.85).aspx

unit PeStruts;

interface

uses
  Windows;

type
  ResourceType = (
        rtUnknown0 = 0,
        rtCursorEntry = 1,
        rtBitmap = 2,
        rtIconEntry = 3,
        rtMenu = 4,
        rtDialog = 5,
        rtString = 6,
        rtFontDir = 7,
        rtFont = 8,
        rtAccelerators = 9,
        rtRCData = 10,
        rtMessageTable = 11,
        rtCursor = 12,
        rtUnknown13 = 13,
        rtIcon = 14,
        rtUnknown15 = 15,
        rtVersion = 16,

        rtUnknown17 = 17,
        rtUnknown18 = 18,
        rtPlugPlay = 19,
        rtVxd = 20,
        rtAnimatedCursor = 21,
        rtAnimatedIcon = 22,
        rtHTML = 23,
        rtXPManifest = 24
  );
  
const

  ResourceTypeName:array[ResourceType]of string = (
    'Unknown0',
    'CursorEntry',
    '位图',
    'IconEntry',
    '菜单',
    '对话框',
    {6}'字符串',
    '字体目录',
    '字体',
    '快捷键',   //
    'RC数据',
    '消息表',
    '光标',
    'Unknown13',
    '图标',
    'Unknown15',
    {10}'版本',
    'Unknown17',
    'Unknown18',
    {13}'PlugPlay',
    {14}'Vxd',
    '动画光标',
    '动画图标',
    'HTML',
    'XPManifest'
    );
    
const
{$region 'Machine Types'}
  //The contents of this field are assumed to be applicable to any machine type
  IMAGE_FILE_MACHINE_UNKNOWN = $0;
  //Matsushita AM33
  IMAGE_FILE_MACHINE_AM33 = $1D3;
  //x64
  IMAGE_FILE_MACHINE_AMD64 = $8664;
  //ARM little endian
  IMAGE_FILE_MACHINE_ARM = $1C0;
  //ARMv7 (or higher) Thumb mode only
  IMAGE_FILE_MACHINE_ARMNT = $1C4;
  //ARMv8 in 64-bit mode
  IMAGE_FILE_MACHINE_ARM64 = $AA64;
  //EFI byte code
  IMAGE_FILE_MACHINE_EBC = $EBC;
  //Intel 386 or later processors and compatible processors
  IMAGE_FILE_MACHINE_I386 = $14C;
  //Intel Itanium processor family
  IMAGE_FILE_MACHINE_IA64 = $200;
  //Mitsubishi M32R little endian
  IMAGE_FILE_MACHINE_M32R = $9041;
  //MIPS16
  IMAGE_FILE_MACHINE_MIPS16 = $266;
  //MIPS with FPU
  IMAGE_FILE_MACHINE_MIPSFPU = $366;
  //MIPS16 with FPU
  IMAGE_FILE_MACHINE_MIPSFPU16 = $466;
  //Power PC little endian
  IMAGE_FILE_MACHINE_POWERPC = $1F0;
  //Power PC with floating point support
  IMAGE_FILE_MACHINE_POWERPCFP = $1F1;
  //MIPS little endian
  IMAGE_FILE_MACHINE_R4000 = $166;
  //Hitachi SH3
  IMAGE_FILE_MACHINE_SH3 = $1A2;
  //Hitachi SH3 DSP
  IMAGE_FILE_MACHINE_SH3DSP = $1A3;
  //Hitachi SH4
  IMAGE_FILE_MACHINE_SH4 = $1A6;
  //Hitachi SH5
  IMAGE_FILE_MACHINE_SH5 = $1A8;
  //ARM or Thumb (“interworking”)
  IMAGE_FILE_MACHINE_THUMB = $1C2;
  //MIPS little-endian WCE v2
  IMAGE_FILE_MACHINE_WCEMIPSV2 = $169;
{$endregion 'Machine Types'}

{$region 'Characteristics'}
  //Image only, Windows CE, and Windows NT? and later. This indicates that the file does not contain base relocations and must therefore be loaded at its preferred base address. If the base address is not available, the loader reports an error. The default behavior of the linker is to strip base relocations from executable (EXE) files.
  IMAGE_FILE_RELOCS_STRIPPED = $0001;
  //Image only. This indicates that the image file is valid and can be run. If this flag is not set, it indicates a linker error.
  IMAGE_FILE_EXECUTABLE_IMAGE = $0002;
  //COFF line numbers have been removed. This flag is deprecated and should be zero.
  IMAGE_FILE_LINE_NUMS_STRIPPED = $0004;
  //COFF symbol table entries for local symbols have been removed. This flag is deprecated and should be zero.
  IMAGE_FILE_LOCAL_SYMS_STRIPPED = $0008;
  //Obsolete. Aggressively trim working set. This flag is deprecated for Windows 2000 and later and must be zero.
  IMAGE_FILE_AGGRESSIVE_WS_TRIM = $0010;
  //Application can handle > 2 GB addresses.
  IMAGE_FILE_LARGE_ADDRESS_AWARE = $0020;
  //This flag is reserved for future use.
  IMAGE_FILE_Characteristics_RESERVED = $0040;
  //Little endian: the least significant bit (LSB) precedes the most significant bit (MSB) in memory. This flag is deprecated and should be zero.
  IMAGE_FILE_BYTES_REVERSED_LO = $0080;
  //Machine is based on a 32-bit-word architecture.
  IMAGE_FILE_32BIT_MACHINE = $0100;
  //Debugging information is removed from the image file.
  IMAGE_FILE_DEBUG_STRIPPED = $0200;
  //If the image is on removable media, fully load it and copy it to the swap file.
  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP = $0400;
  //If the image is on network media, fully load it and copy it to the swap file.
  IMAGE_FILE_NET_RUN_FROM_SWAP = $0800;
  //The image file is a system file, not a user program.
  IMAGE_FILE_SYSTEM = $1000;
  //The image file is a dynamic-link library (DLL). Such files are considered executable files for almost all purposes, although they cannot be directly run.
  IMAGE_FILE_DLL = $2000;
  //The file should be run only on a uniprocessor machine.
  IMAGE_FILE_UP_SYSTEM_ONLY = $4000;
  //Big endian: the MSB precedes the LSB in memory. This flag is deprecated and should be zero.
  IMAGE_FILE_BYTES_REVERSED_HI = $8000;
{$endregion 'Characteristics'}

{$region '_IMAGE_OPTIONAL_HEADER64.DLLCharacteristics'}
  //_IMAGE_OPTIONAL_HEADER64.DLLCharacteristics
    //DLL can be relocated at load time.
  IMAGE_DLL_CHARACTERISTICS_DYNAMIC_BASE = $0040;
  //Code Integrity checks are enforced.
  IMAGE_DLL_CHARACTERISTICS_FORCE_INTEGRITY = $0080;
  //Image is NX compatible.
  IMAGE_DLL_CHARACTERISTICS_NX_COMPAT = $0100;
  //Isolation aware, but do not isolate the image.
  IMAGE_DLL_CHARACTERISTICS_NO_ISOLATION = $0200;
  //Does not use structured exception (SE) handling. No SE handler may be called in this image.
  IMAGE_DLL_CHARACTERISTICS_NO_SEH = $0400;
  //Do not bind the image.
  IMAGE_DLL_CHARACTERISTICS_NO_BIND = $0800;
  //A WDM driver.
  IMAGE_DLL_CHARACTERISTICS_WDM_DRIVER = $2000;
  //Terminal Server aware.
  IMAGE_DLL_CHARACTERISTICS_TERMINAL_SERVER_AWARE = $8000;
{$endregion '_IMAGE_OPTIONAL_HEADER64.DLLCharacteristics'}

{$region 'Subsystem'}
//Windows Subsystem
  //An unknown subsystem
  IMAGE_SUBSYSTEM_UNKNOWN = 0;
  //Device drivers and native Windows processes
  IMAGE_SUBSYSTEM_NATIVE = 1;
  //The Windows graphical user interface (GUI) subsystem
  IMAGE_SUBSYSTEM_WINDOWS_GUI = 2;
  //The Windows character subsystem
  IMAGE_SUBSYSTEM_WINDOWS_CU = 3;
  //The Posix character subsystem
  IMAGE_SUBSYSTEM_POSIX_CUI = 7;
  //Windows CE
  IMAGE_SUBSYSTEM_WINDOWS_CE_GUI = 9;
  //An Extensible Firmware Interface (EFI) application
  IMAGE_SUBSYSTEM_EFI_APPLICATION = 10;
  //An EFI driver with boot services
  IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER = 11;
  //An EFI driver with run-time services
  IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER = 12;
  //An EFI ROM image
  IMAGE_SUBSYSTEM_EFI_ROM = 13;
  //XBOX
  IMAGE_SUBSYSTEM_XBOX = 14;
{$endregion 'Subsystem'}

{$region 'Section Flags'}
  //The section should not be padded to the next boundary. This flag is obsolete and is replaced by IMAGE_SCN_ALIGN_1BYTES. This is valid only for object files.
  IMAGE_SCN_TYPE_NO_PAD = $00000008;
  //The section contains executable code.
  IMAGE_SCN_CNT_CODE = $00000020;
  //The section contains initialized data.
  IMAGE_SCN_CNT_INITIALIZED_DATA = $00000040;
  //The section contains uninitialized data.
  IMAGE_SCN_CNT_UNINITIALIZED_DATA = $00000080;
  //Reserved for future use.
  IMAGE_SCN_LNK_OTHER = $00000100;
  //The section contains comments or other information. The .drectve section has this type. This is valid for object files only.
  IMAGE_SCN_LNK_INFO = $00000200;
  //The section will not become part of the image. This is valid only for object files.
  IMAGE_SCN_LNK_REMOVE = $00000800;
  //The section contains COMDAT data. For more information, see section 5.5.6, “COMDAT Sections (Object Only).” This is valid only for object files.
  IMAGE_SCN_LNK_COMDAT = $00001000;
  //The section contains data referenced through the global pointer (GP).
  IMAGE_SCN_GPREL = $00008000;
  //Reserved for future use.
  IMAGE_SCN_MEM_PURGEABLE = $00020000;
  //For ARM machine types, the section contains Thumb code.  Reserved for future use with other machine types.
  IMAGE_SCN_MEM_16BIT = $00020000;
  //Reserved for future use.
  IMAGE_SCN_MEM_LOCKED = $00040000;
  //Reserved for future use.
  IMAGE_SCN_MEM_PRELOAD = $00080000;
  //Align data on a 1-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_1BYTES = $00100000;
  //Align data on a 2-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_2BYTES = $00200000;
  //Align data on a 4-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_4BYTES = $00300000;
  //Align data on an 8-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_8BYTES = $00400000;
  //Align data on a 16-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_16BYTES = $00500000;
  //Align data on a 32-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_32BYTES = $00600000;
  //Align data on a 64-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_64BYTES = $00700000;
  //Align data on a 128-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_128BYTES = $00800000;
  //Align data on a 256-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_256BYTES = $00900000;
  //Align data on a 512-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_512BYTES = $00A00000;
  //Align data on a 1024-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_1024BYTES = $00B00000;
  //Align data on a 2048-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_2048BYTES = $00C00000;
  //Align data on a 4096-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_4096BYTES = $00D00000;
  //Align data on an 8192-byte boundary. Valid only for object files.
  IMAGE_SCN_ALIGN_8192BYTES = $00E00000;
  //The section contains extended relocations.
  IMAGE_SCN_LNK_NRELOC_OVFL = $01000000;
  //The section can be discarded as needed.
  IMAGE_SCN_MEM_DISCARDABLE = $02000000;
  //The section cannot be cached.
  IMAGE_SCN_MEM_NOT_CACHED = $04000000;
  //The section is not pageable.
  IMAGE_SCN_MEM_NOT_PAGED = $08000000;
  //The section can be shared in memory.
  IMAGE_SCN_MEM_SHARED = $10000000;
  //The section can be executed as code.
  IMAGE_SCN_MEM_EXECUTE = $20000000;
  //The section can be read.
  IMAGE_SCN_MEM_READ = $40000000;
  //The section can be written to.
  IMAGE_SCN_MEM_WRITE = $80000000;
{$Endregion 'Section Flags'}

  MFR_POPUP = 1;
  
type
  PQWORD = ^QWORD;
  QWORD = ULONGLONG;

type
  PImageOptionalHeader64 = ^TImageOptionalHeader64;
  _IMAGE_OPTIONAL_HEADER64 = packed record
    { Standard fields. }
    Magic: Word;
    MajorLinkerVersion: Byte;
    MinorLinkerVersion: Byte;
    SizeOfCode: DWORD;
    SizeOfInitializedData: DWORD;
    SizeOfUninitializedData: DWORD;
    AddressOfEntryPoint: DWORD;
    BaseOfCode: DWORD;
    // BaseOfData: DWORD;  //64位程序中没有此物
    { NT additional fields. }
    ImageBase: QWORD;
    SectionAlignment: DWORD;
    FileAlignment: DWORD;
    MajorOperatingSystemVersion: Word;
    MinorOperatingSystemVersion: Word;
    MajorImageVersion: Word;
    MinorImageVersion: Word;
    MajorSubsystemVersion: Word;
    MinorSubsystemVersion: Word;
    Win32VersionValue: DWORD;
    SizeOfImage: DWORD;
    SizeOfHeaders: DWORD;
    CheckSum: DWORD;
    Subsystem: Word;
    DllCharacteristics: Word;
    SizeOfStackReserve: QWORD;
    SizeOfStackCommit: QWORD;
    SizeOfHeapReserve: QWORD;
    SizeOfHeapCommit: QWORD;
    LoaderFlags: DWORD;
    NumberOfRvaAndSizes: DWORD;
    DataDirectory: packed array[0..IMAGE_NUMBEROF_DIRECTORY_ENTRIES - 1] of TImageDataDirectory;
  end;
  TImageOptionalHeader64 = _IMAGE_OPTIONAL_HEADER64;
  IMAGE_OPTIONAL_HEADER64 = _IMAGE_OPTIONAL_HEADER64;

type
  PImageImportDirectory = ^TImageImportDirectory;
  _IMAGE_IMPORT_DIRECTORY = packed record
      OriginalFirstThunk:DWORD;
      TimeDateStamp: DWord;
      ForwarderChain: DWord;
      Name: DWord;
      FirstThunk: DWord;
  end;
  {$EXTERNALSYM _IMAGE_IMPORT_DIRECTORY}
  TImageImportDirectory = _IMAGE_IMPORT_DIRECTORY;
  IMAGE_IMPORT_DIRECTORY = _IMAGE_IMPORT_DIRECTORY;
  {$EXTERNALSYM IMAGE_IMPORT_DIRECTORY}

  PImageImportByName = ^TImageImportByName;
  _IMAGE_IMPORT_BY_NAME = packed record
    Hint:Word;
    Name: array[0..0] of Byte;
  end;
  {$EXTERNALSYM _IMAGE_IMPORT_BY_NAME}
  TImageImportByName = _IMAGE_IMPORT_BY_NAME;
  IMAGE_IMPORT_BY_NAME = _IMAGE_IMPORT_BY_NAME;
  {$EXTERNALSYM IMAGE_IMPORT_BY_NAME}

type
  PImageResourceDirStringU = ^TImageResourceDirStringU;
  TImageResourceDirStringU = packed record
    Length: WORD;
    NameString: array[0..0] of WCHAR;
  end;
  PImageResourceDirectoryEntry = ^TImageResourceDirectoryEntry;
  TImageResourceDirectoryEntry = packed record
    Name : DWORD;   //最高位为0时，低31位是资源类型；最高位为1时，低31位是PTmageResourceDirStringU
    OffsetToData : DWORD;//最高位为0时，低31位是PImageResourceDataEntry；
                         //最高位为1时，低31位是下一个PImageResourceDirectoryEntry
  end;
  PImageResourceDirectory = ^TImageResourceDirectory;
  _IMAGE_RESOURCE_DIRECTORY = packed record
      Characteristics:DWord;
      TimeDateStamp: DWord;
      MajorVersion: Word;
      MinorVersion: Word;
      NumberOfNamedEntries: Word;
      NumberOfIdEntries: Word;
      DirectoryEntry :packed array[0..0] of TImageResourceDirectoryEntry;
  end;
  {$EXTERNALSYM _IMAGE_RESOURCE_DIRECTORY}
  TImageResourceDirectory = _IMAGE_RESOURCE_DIRECTORY;
  IMAGE_RESOURCE_DIRECTORY = _IMAGE_RESOURCE_DIRECTORY;
  {$EXTERNALSYM _IMAGE_RESOURCE_DIRECTORY}

  PImageResourceDataEntry = ^TImageResourceDataEntry;
  _IMAGE_RESOURCE_DATA_ENTRY = packed record
      Data: DWord;
      Size: DWord;
      Codepage: DWord;
      Reserved: DWord;
  end;
  {$EXTERNALSYM _IMAGE_RESOURCE_DATA_ENTRY}
  TImageResourceDataEntry = _IMAGE_RESOURCE_DATA_ENTRY;
  IMAGE_RESOURCE_DATA_ENTRY = _IMAGE_RESOURCE_DATA_ENTRY;
  {$EXTERNALSYM _IMAGE_RESOURCE_DATA_ENTRY}

  
  PNEWHEADER  = ^TNEWHEADER ;
  TNEWHEADER  = packed record
    Reserved: Word; { Currently zero }
    ResType: Word; { 1 for icons }
    ResCount: Word; { Number of components }
  end;
  PIconResInfo = ^TIconResInfo;
  TIconResInfo = packed record
    bWidth: Byte;
    bHeight: Byte;
    bColorCount: Byte;
    bReserved: Byte;
    wPlanes: Word;
    wBitCount: Word;
    lBytesInRes: DWORD;
    wNameOrdinal: Word; { Points to component }
  end;

  PCursorResInfo = ^TCursorResInfo;
  TCursorResInfo = packed record
    wWidth: Word;
    wHeight: Word;
    wPlanes: Word;
    wBitCount: Word;
    lBytesInRes: DWORD;
    wNameOrdinal: Word; { Points to component }
  end;
  
  PAString = ^TAString;
  TAString = packed record
    wLength: WORD;
    wValueLength: WORD;
    wType: WORD;
    szKey: PWCHAR;
    Padding: PWCHAR;
    Value: PWCHAR;
  end;
  PStringTable = ^TStringTable;
  TStringTable = packed record
    wLength: WORD;
    wValueLength: WORD;
    wType: WORD;
    szKey: array[0..8] of WideChar;
    Children: array of TAString;
  end;

  PStringFileInfo = ^TStringFileInfo;
  TStringFileInfo = packed record
    wLength: WORD;
    wValueLength: WORD;
    wType: WORD;
    szKey: array[0..14] of WideChar; //StringFileInfo
    //Padding: WORD;
    Children: array of TStringTable;
  end;
  PAVar = ^TAVar;
  TAVar = packed record
    wLength: WORD;
    wValueLength: WORD;
    wType: WORD;
    szKey: array[0..11] of WideChar;   //Translation
    Padding: WORD;
    Value: Pointer;
  end;

  PVarFileInfo = ^TVarFileInfo;
  TVarFileInfo = packed record
    wLength: WORD;
    wValueLength: WORD;
    wType: WORD;
    szKey: array[0..11] of WideChar;  //VarFileInfo
    Padding: WORD;
    Children: TAVar;
  end;
  //  http://msdn.microsoft.com/en-us/library/aa914916.aspx
  PVS_VERSIONINFO = ^TVS_VERSIONINFO;
  TVS_VERSIONINFO = packed record
    wLength : Word;
    wValueLength : Word;
    wType : Word;
    szKey : array[0..15] of WideChar;  //VS_VERSION_INFO
    Padding1 : Word;
    Value : tagVS_FIXEDFILEINFO;
    //Padding2:Word;
    //Children:Word;
    StringFileInfo: TStringFileInfo;
    VarFileInfo: TVarFileInfo;
  end;

  PDlgTemplateEx = ^TDlgTemplateEx;
  //{$EXTERNALSYM DLGTEMPLATEEX}
  DLGTEMPLATEEX = packed record
    dlgVer: WORD;
    signature: WORD;
    helpID: DWORD;
    exStyle: DWORD;
    style: DWORD;
    cDlgItems:WORD;
    x: SHORT;
    y: SHORT;
    cx: SHORT;
    cy: SHORT;
    menu: WORD;
    windowClass: WORD;
    title :WCHAR;
    pointsize:WORD;
    weight:WORD;
    italic:Byte;
    charset:Byte;
    typeface:WCHAR;
  end;
  TDlgTemplateEx = DLGTEMPLATEEX;
  //因为TDlgTemplateEx中存在有不定长变量title  所以吧结构体分成两部分
  PDlgTemplateEx2 = ^TDlgTemplateEx2;
  //{$EXTERNALSYM DLGTEMPLATEEX}
  DLGTEMPLATEEX2 = packed record
    pointsize:WORD;
    weight:WORD;
    italic:Byte;
    charset:Byte;
    typeface:WCHAR;
  end;
  TDlgTemplateEx2 = DLGTEMPLATEEX2;
  
  PDlgItemTemplateEx = ^TDlgItemTemplateEx;
  DLGITEMTEMPLATEEX = packed record
    helpID:DWORD;
    exStyle:DWORD;
    style:DWORD;
    x:short;
    y:short;
    cx:short;
    cy:short;
    id:DWORD;
    windowClass:DWORD;
    title:WORD;
    extraCount:WORD;
  end;
  TDlgItemTemplateEx = DLGITEMTEMPLATEEX;

  PMenuHeader = ^TMenuHeader;
  tagMENUHEADER = packed record
    wVersion : WORD;
    cbHeaderSize : WORD;
  end;
  TMenuHeader = tagMENUHEADER;

  PNormalMenu = ^TNormalMenu;
  tagNORMALMENU = packed record
    resInfo : WORD;
    menuText : Pointer;
  end;
  TNormalMenu = tagNORMALMENU;

  PNormalMenuItem = ^TNormalMenuItem;
  tagNORMALMENUITEM = packed record
    resInfo : WORD;
    id : WORD;
    menuText : Pointer;
  end;
  TNormalMenuItem = tagNORMALMENUITEM;

  PPopUpMenuItem = ^TPopUpMenuItem;
  tagPOPUPMENUITEM = packed record
    _type :DWORD;
    state:DWORD;
    id:DWORD;
    resInfo : WORD;
    menuText : Pointer;
  end;
  TPopUpMenuItem = tagPopUpMenuItem;

  PMenuExTemplateHeader = ^TMenuExTemplateHeader;
  tagMENUEX_TEMPLATE_HEADER = packed record
    wVersion : WORD;
    wOffset:WORD;
    dwHelpId:DWORD;
  end;
  TMenuExTemplateHeader = tagMENUEX_TEMPLATE_HEADER;


  PImageTlsDirectory=^TImageTlsDirectory;
  _IMAGE_TLS_DIRECTORY32 = packed record
    StartAddressOfRawData:DWORD;  //TLS数值模板的起始地址
    EndAddressOfRawData:DWORD;    //TLS数值模板的结束地址
    AddressOfIndex:DWORD;         //TLS索引的位置
    AddressOfCallBacks:DWORD;     //回调函数地址的偏移
    SizeOfZeroFill:DWORD;
    Characteristics:DWORD;
  end;
  TImageTlsDirectory = _IMAGE_TLS_DIRECTORY32;
  IMAGE_TLS_DIRECTORY32 = _IMAGE_TLS_DIRECTORY32;



implementation

end.
