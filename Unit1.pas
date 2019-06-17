unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, ExtCtrls, ShellAPI, ImgList, PeStruts,
  Memory_Common, ToolWin, ResConstString, math, GIFImg, pngimage, jpeg;

type TdisplayType = (Display_Default, //默认
    Display_Bin, //二进制
    Display_Ascii, //文本
    Display_Unicode, //文本（宽字节）
    Display_IMG //图片
    );
type ContextControl = (Cc_List,
    Cc_Memo,
    Cc_Img,
    Cc_VerSion,
    Cc_Dialog,
    Cc_Menu
    );

type
  TFMain = class(TForm)
    TreeView1: TTreeView;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Splitter1: TSplitter;
    ListView1: TListView;
    Memo1: TMemo;
    Pnl_res: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    ToolBar1: TToolBar;
    btn_saveBin: TToolButton;
    ToolButton2: TToolButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    FontDialog1: TFontDialog;
    N12: TMenuItem;
    ImageList1: TImageList;
    Pnl_Context: TPanel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    ScrollBox_img: TScrollBox;
    panel_Img: TPanel;
    PopupMenu1: TPopupMenu;
    showBin1: TMenuItem;
    pnl_verInfo: TPanel;
    Panel1: TPanel;
    lv_ver: TListView;
    edt_ver_fileVersion: TEdit;
    edt_ver_productVersion: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_ver_OS: TEdit;
    Label5: TLabel;
    edt_ver_filetype: TEdit;
    Label6: TLabel;
    edt_ver_subSystype: TEdit;
    Label7: TLabel;
    edt_ver_BinaryVersion: TEdit;
    cb_ver_ff_debug: TCheckBox;
    cb_ver_ff_preRelease: TCheckBox;
    cb_ver_ff_infoinferred: TCheckBox;
    cb_ver_ff_patched: TCheckBox;
    cb_ver_ff_privateBuild: TCheckBox;
    cb_ver_ff_specialBuild: TCheckBox;
    N13: TMenuItem;
    pnl_Dialog: TPanel;
    Panel3: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edt_dlg_X: TEdit;
    edt_dlg_Y: TEdit;
    edt_dlg_width: TEdit;
    edt_dlg_Height: TEdit;
    Label12: TLabel;
    edt_dlg_title: TEdit;
    edt_dlg_font: TEdit;
    Label13: TLabel;
    edt_dlg_fontSize: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    edt_dlg_menu: TEdit;
    Label16: TLabel;
    edt_dlg_fontweight: TEdit;
    edt_dlg_ClassName: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    edt_dlg_fontItalic: TComboBox;
    Label19: TLabel;
    edt_dlg_charset: TEdit;
    tv_dlg: TTreeView;
    ToolButton1: TToolButton;
    cb_dlg_pg_Static: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cb_dlg_style_BORDER: TCheckBox;
    cb_dlg_style_SIZEBOX: TCheckBox;
    cb_dlg_style_DLGFRAME: TCheckBox;
    cb_dlg_style_SYSMENU: TCheckBox;
    cb_dlg_style_MINIMIZEBOX: TCheckBox;
    cb_dlg_style_MAXIMIZEBOX: TCheckBox;
    cb_dlg_style_VISIBLE: TCheckBox;
    cb_dlg_style_DISABLED: TCheckBox;
    cb_dlg_style_Caption: TCheckBox;
    cb_dlg_style_HSCROLL: TCheckBox;
    cb_dlg_style_VSCROLL: TCheckBox;
    cb_dlg_style_CLIPSIBLINGS: TCheckBox;
    cb_dlg_style_CLIPCHILDREN: TCheckBox;
    cb_dlg_style_livestyle: TComboBox;
    cb_dlg_style_winState: TComboBox;
    Label20: TLabel;
    Label21: TLabel;
    cb_dlg_style_EX_RIGHT: TCheckBox;
    cb_dlg_style_EX_CLIENTEDGE: TCheckBox;
    cb_dlg_style_EX_TRANSPARENT: TCheckBox;
    cb_dlg_style_EX_MDICHILD: TCheckBox;
    cb_dlg_style_EX_DLGMODALFRAME: TCheckBox;
    cb_dlg_style_EX_LEFTSCROLLBAR: TCheckBox;
    cb_dlg_style_EX_CONTEXTHELP: TCheckBox;
    cb_dlg_style_EX_WINDOWEDGE: TCheckBox;
    cb_dlg_style_EX_ACCEPTFILES: TCheckBox;
    cb_dlg_style_EX_NOPARENTNOTIFY: TCheckBox;
    cb_dlg_style_EX_TOPMOST: TCheckBox;
    cb_dlg_style_EX_TOOLWINDOW: TCheckBox;
    cb_dlg_style_EX_RTLREADING: TCheckBox;
    cb_dlg_style_EX_CONTROLPARENT: TCheckBox;
    cb_dlg_style_EX_APPWINDOW: TCheckBox;
    cb_dlg_style_EX_LAYOUTRTL: TCheckBox;
    cb_dlg_style_EX_NOINHERITLAYOUT: TCheckBox;
    cb_dlg_style_EX_COMPOSITED: TCheckBox;
    cb_dlg_style_EX_STATICEDGE: TCheckBox;
    cb_dlg_style_EX_LAYERED: TCheckBox;
    cb_dlg_style_EX_NOACTIVATE: TCheckBox;
    cb_dlg_style_EX_NOREDIRECTIONBITMAP: TCheckBox;
    ts_dialogstyle: TTabSheet;
    cb_dlg_style_DS_3DLOOK: TCheckBox;
    cb_dlg_style_DS_CENTERMOUSE: TCheckBox;
    cb_dlg_style_DS_ABSALIGN: TCheckBox;
    cb_dlg_style_DS_CENTER: TCheckBox;
    cb_dlg_style_DS_CONTEXTHELP: TCheckBox;
    cb_dlg_style_DS_CONTROL: TCheckBox;
    cb_dlg_style_DS_FIXEDSYS: TCheckBox;
    cb_dlg_style_DS_LOCALEDIT: TCheckBox;
    cb_dlg_style_DS_MODALFRAME: TCheckBox;
    cb_dlg_style_DS_NOFAILCREATE: TCheckBox;
    cb_dlg_style_DS_NOIDLEMSG: TCheckBox;
    cb_dlg_style_DS_SETFONT: TCheckBox;
    cb_dlg_style_DS_SETFOREGROUND: TCheckBox;
    cb_dlg_style_DS_SYSMODAL: TCheckBox;
    ts_ControlStyles: TTabSheet;
    cb_dlg_style_CS_type: TEdit;
    cb_dlg_style_CS_value: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    pnl_menu: TPanel;
    TabSheet3: TTabSheet;
    Label24: TLabel;
    cb_dlg_style_CS_Btn_type: TComboBox;
    Label25: TLabel;
    Label26: TLabel;
    cb_dlg_style_CS_Btn_HA: TComboBox;
    cb_dlg_style_CS_Btn_VA: TComboBox;
    cb_dlg_style_CS_Btn_BITMAP: TCheckBox;
    cb_dlg_style_CS_Btn_ICON: TCheckBox;
    cb_dlg_style_CS_Btn_FLAT: TCheckBox;
    cb_dlg_style_CS_Btn_LEFTTEXT: TCheckBox;
    cb_dlg_style_CS_Btn_MULTILINE: TCheckBox;
    cb_dlg_style_CS_Btn_NOTIFY: TCheckBox;
    cb_dlg_style_CS_Btn_PUSHLIKE: TCheckBox;
    TabSheet4: TTabSheet;
    cb_dlg_style_CS_Edt_AUTOHSCROLL: TCheckBox;
    cb_dlg_style_CS_Edt_AUTOVSCROLL: TCheckBox;
    cb_dlg_style_CS_Edt_LOWERCASE: TCheckBox;
    cb_dlg_style_CS_Edt_MULTILINE: TCheckBox;
    cb_dlg_style_CS_Edt_NOHIDESEL: TCheckBox;
    cb_dlg_style_CS_Edt_NUMBER: TCheckBox;
    cb_dlg_style_CS_Edt_OEMCONVERT: TCheckBox;
    cb_dlg_style_CS_Edt_PASSWORD: TCheckBox;
    cb_dlg_style_CS_Edt_READONLY: TCheckBox;
    cb_dlg_style_CS_Edt_UPPERCASE: TCheckBox;
    cb_dlg_style_CS_Edt_WANTRETURN: TCheckBox;
    Label27: TLabel;
    cb_dlg_style_CS_Edt_Ag: TComboBox;
    TabSheet5: TTabSheet;
    Label28: TLabel;
    Label29: TLabel;
    cb_dlg_style_CS_SS_type: TComboBox;
    cb_dlg_style_CS_SS_Ell: TComboBox;
    cb_dlg_style_CS_SS_NOPREFIX: TCheckBox;
    cb_dlg_style_CS_SS_NOTIFY: TCheckBox;
    cb_dlg_style_CS_SS_CENTERIMAGE: TCheckBox;
    cb_dlg_style_CS_SS_RIGHTJUST: TCheckBox;
    cb_dlg_style_CS_SS_REALSIZEIMAGE: TCheckBox;
    cb_dlg_style_CS_SS_SUNKEN: TCheckBox;
    cb_dlg_style_CS_SS_REALSIZECONTROL: TCheckBox;
    Panel4: TPanel;
    tv_menutree: TTreeView;
    cb_Menu_ExtMenu: TCheckBox;
    cb_Menu_Checked: TCheckBox;
    cb_Menu_RIGHTORDER: TCheckBox;
    cb_Menu_POPUP: TCheckBox;
    cb_Menu_Grayed: TCheckBox;
    cb_Menu_APPEND: TCheckBox;
    cb_Menu_Bitmap: TCheckBox;
    cb_Menu_MENUBREAK: TCheckBox;
    cb_Menu_DISABLED: TCheckBox;
    cb_Menu_Default: TCheckBox;
    cb_Menu_MENUBARBREAK: TCheckBox;
    cb_Menu_END: TCheckBox;
    cb_Menu_RIGHTJUSTIFY: TCheckBox;
    cb_Menu_MOUSESELECT: TCheckBox;
    cb_Menu_DELETE: TCheckBox;
    cb_Menu_BYPOSITION: TCheckBox;
    cb_Menu_SEPARATOR: TCheckBox;
    cb_Menu_OWNERDRAW: TCheckBox;
    cb_Menu_HILITE: TCheckBox;
    cb_Menu_RADIOCHECK: TCheckBox;
    procedure N4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure N12Click(Sender: TObject);
    procedure btn_saveBinClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure showBin1Click(Sender: TObject);
    procedure tv_dlgDblClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure tv_dlgChange(Sender: TObject; Node: TTreeNode);
    procedure tv_menutreeChange(Sender: TObject; Node: TTreeNode);
  private
    fileMap: THandle;
    pBaseAddress: Pointer;
    dosHeader: PImageDosHeader;
    ntHeader: PImageNtHeaders;
    Is64Image: Boolean;
    { Private declarations }
    procedure OpenAndMapping(Filename: string);
    procedure CloseAndDestroy;
    procedure initTreeList;
    procedure DisplayResource(TreeNode: TTreeNode);
    procedure DisplayChild(Node: TTreeNode);
    procedure ChangeResDisplayWay(_type: TdisplayType);
    procedure DisplayResourceByDefault(TreeNode: TTreeNode);
    procedure DisplayResourceByHex(TreeNode: TTreeNode);
    procedure DisplayResourceByText(TreeNode: TTreeNode);
    procedure DisplayResourceByTextAscsii(TreeNode: TTreeNode);
    procedure DisplayResourceByTextUnicode(TreeNode: TTreeNode);
    procedure DisplayResourceByImg(TreeNode: TTreeNode);
    procedure ShowContextControl(cc: ContextControl);
    procedure SetResInfo(aStr: string); overload;
    procedure SetResInfo(TreeNode: TTreeNode); overload;
    procedure SetResInfo(const aFormat: string; const Args: array of const); overload;
    procedure GetResourceStringBlock(BlockName: string; TreeNode: TTreeNode);
    procedure GetResourceBmpBlock(TreeNode: TTreeNode);
    procedure GetResourceIconOrCursor(TreeNode: TTreeNode; _type: ResourceType);
    procedure GetResourceVersion(TreeNode: TTreeNode);
    procedure GetResourceDialog(TreeNode: TTreeNode);
    procedure display_style_Windows(style: DWORD; isWindow: boolean);
    procedure display_style_Ex_Windows(style: DWORD);
    procedure display_style_Dialog(style: DWORD);
    procedure display_style_ControlStyles(style: DWORD; ControlType: string);
    procedure GetResourceMenu(TreeNode: TTreeNode);
    procedure display_style_ControlStyles_button(style: DWORD);
    procedure display_style_ControlStyles_Edit(style: DWORD);
    procedure display_style_ControlStyles_Static(style: DWORD);
    procedure GetResourceMenuList(Node: TTreeNode; var normalMenu: PNormalMenu);
    procedure GetResourceMenuExList(Node: TTreeNode; var PopUpMenu: PPopUpMenuItem);
  public
    OldListWProc: TWndMethod;
    ResDisplayType: TdisplayType;
    ImportfRva: DWORD;
    ExportfRva: DWORD;
    ResourcefRva: DWORD;
    { Public declarations }
    procedure NewListWProc(var Message: TMessage);
  end;

var
  FMain: TFMain;
  //创建显示的dialog句柄
  DialogWinHandle: Thandle;

implementation
uses
  pe64;

{$R *.dfm}

function Win_DialogProc(hwndDlg: THandle; uMsg: UINT; _wParam: WPARAM;
  _lParam: LPARAM): integer; stdcall;
begin
  result := 0;
  if uMsg = WM_SYSCOMMAND then
  begin
    if _wParam = SC_CLOSE then
    begin
      DestroyWindow(DialogWinHandle);
      DialogWinHandle := 0;
      result := 1;
    end;
  end;
end;

function Win_DialogProc2(hwndDlg: THandle; uMsg: UINT; _wParam: WPARAM;
  _lParam: LPARAM): integer; stdcall;
begin
  result := 0;
  if uMsg = WM_INITDIALOG then
  begin
    result := 1;
  end;
end;


procedure TFMain.NewListWProc(var Message: TMessage);
var
  pcFileName: PChar;
  iSize, iFileCount: integer;
begin
  if Message.Msg = WM_DROPFILES then
  begin
    iFileCount := DragQueryFile(Message.wParam, $FFFFFFFF, nil, 255);
    if iFileCount = 1 then //只处理单个文件拖入
    begin
      iSize := DragQueryFile(Message.wParam, 0, nil, 0) + 1;
      pcFileName := StrAlloc(iSize);
      DragQueryFile(Message.wParam, 0, pcFileName, iSize);
      if FileExists(pcFileName) then
      begin
        OpenAndMapping(pcFileName);
      end;
      StrDispose(pcFileName);
      DragFinish(Message.wParam);
    end;
  end;
  OldListWProc(Message);
end;

procedure TFMain.OpenAndMapping(Filename: string);
var
  fileHandle: THandle;
begin
  CloseAndDestroy;
 //打开文件
  if not FileExists(Filename) then
    raise Exception.Create('请求打开的文件不存在！');

  //打开文件
  fileHandle := CreateFile(PChar(filename), GENERIC_READ, FILE_SHARE_READ, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if fileHandle = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('文件打开失败！' + SysErrorMessage(GetLastError));
    Exit;
  end;
  //创建内存映射
  fileMap := CreateFileMapping(fileHandle, nil, PAGE_READONLY, 0, 0, nil);
  if fileMap = 0 then
  begin
    ShowMessage('创建内存映射失败！');
    Exit;
  end;
  CloseHandle(fileHandle);
  //映射到当前进程，pBaseAddress是基址
  pBaseAddress := MapViewOfFile(fileMap, FILE_MAP_READ, 0, 0, 0);
  if pBaseAddress = nil then
  begin
    ShowMessage('获取地址失败！');
    Exit;
  end;
   //获取Dos信息头部结构数据
  dosHeader := pImageDosHeader(pBaseAddress);
  //判断Dos标识
  if dosHeader.e_magic <> IMAGE_DOS_SIGNATURE then
  begin
    ShowMessage('不可识别的文件格式！');
    Exit;
  end;
  //获取NT信息头部结构数据，IsBadReadPtr判断指针是否可读，ntHeader.Signature是NT标识
  ntHeader := pImageNtHeaders(LongInt(pBaseAddress) + dosHeader._lfanew);
  if (IsBadReadPtr(ntHeader, SizeOf(TImageNtHeaders))) or
    (ntHeader.Signature <> IMAGE_NT_SIGNATURE) then
  begin
    ShowMessage('不是有效地Win32程序！');
    Exit;
  end;
  //是64位程序
  Is64Image := ntHeader.OptionalHeader.Magic = $020B;
  if Is64Image then
  begin
    ListView1.Columns[1].Width := 120;
    StatusBar1.Panels[0].Text := '64位';
  end else begin
    ListView1.Columns[1].Width := 65;
    StatusBar1.Panels[0].Text := '32位';
  end;

  initTreeList;
end;

procedure TFMain.SetResInfo(aStr: string);
begin
  StatusBar1.Panels[0].Text := aStr;
end;

procedure TFMain.SetResInfo(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: DWORD;
  ImageResourceDataEntry: PImageResourceDataEntry;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataOffset := ImageResourceDataEntry.Data - ResourcefRva;
  DataLen := ImageResourceDataEntry.Size;
  SetResInfo('偏移=%.8X , 大小=%.8X', [DataOffset, DataLen])
end;

procedure TFMain.SetResInfo(const aFormat: string; const Args: array of const);
begin
  SetResInfo(Format(aFormat, Args));
end;

procedure TFMain.showBin1Click(Sender: TObject);
begin
  DisplayResource(TreeView1.Selected);
end;

procedure TFMain.ShowContextControl(cc: ContextControl);
begin
  case cc of
    Cc_List: begin
        ListView1.BringToFront;
      end;
    Cc_Memo: begin
        Pnl_res.BringToFront;
      end;
    Cc_Img: begin
        Image1.Left := 0;
        Image1.Top := 0;
        panel_Img.ClientWidth := (panel_Img.BevelWidth * 2) + Image1.Width;
        panel_Img.ClientHeight := (panel_Img.BevelWidth * 2) + Image1.Height;
      //让panel_Img在scrollbox居中
        if panel_Img.Width > ScrollBox_img.Width then
          panel_Img.Left := 0
        else
          panel_Img.Left := (ScrollBox_img.Width - panel_Img.Width) div 2;

        if panel_Img.Height > ScrollBox_img.Height then
          panel_Img.Top := 0
        else
          panel_Img.Top := (ScrollBox_img.Height - panel_Img.Height) div 2;
        ScrollBox_img.BringToFront;
      end;
    Cc_VerSion: begin
        pnl_verInfo.BringToFront;
      end;
    Cc_Dialog: begin
        pnl_Dialog.BringToFront;
      end;
    Cc_Menu: begin
        pnl_Menu.BringToFront;
      end;
  end;
end;

procedure TFMain.initTreeList;
var
  treenode: TTreeNode;
begin
  treenode := TreeView1.Items.AddChildObject(nil, '头部', Pointer(TREE_HEADER));
  TreeView1.Items.AddChildObject(treenode, 'Exe 头部', Pointer(TREE_EXEHEADER));
  TreeView1.Items.AddChildObject(treenode, 'Coff 头部', Pointer(TREE_COFFHEADER));
  TreeView1.Items.AddChildObject(treenode, '可选头部', Pointer(TREE_OPTHEADER));
  treenode := TreeView1.Items.AddChildObject(treenode, '区段头部', Pointer(TREE_SECTHEADER));
  DisplaySectionHeader(pBaseAddress, treenode);
  treenode := TreeView1.Items.AddChildObject(nil, '导出', Pointer(TREE_EXPORT));
  ExportfRva := DisplayExportHeader(pBaseAddress, treenode);
  if ExportfRva = $FFFFFFFF then
  begin
    treenode.Delete;
  end;
  treenode := TreeView1.Items.AddChildObject(nil, '导入', Pointer(TREE_IMPORT));
  ImportfRva := DisplayImportDll(pBaseAddress, treenode);
  if ImportfRva = $FFFFFFFF then
  begin
    treenode.Delete;
  end;
  treenode := TreeView1.Items.AddChildObject(nil, '资源', Pointer(TREE_RESOURCE));
  ResourcefRva := DisplayResourceExpandingMainNode(pBaseAddress, treenode);

  ExtractIconCursorLink(treenode);
end;

procedure TFMain.btn_saveBinClick(Sender: TObject);
var
  ParentNode: TTreeNode;
  st: Tlist;
  mem: TMemoryStream;

  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;

  savedialog: TSaveDialog;
begin
  st := Tlist.Create;
  ParentNode := TreeView1.Selected.Parent;
  while Assigned(ParentNode.Parent) and (ParentNode.Parent is TTreeNode) do
  begin
    st.Add(ParentNode);
    ParentNode := ParentNode.Parent;
  end;
  if ParentNode.Text <> TREE_RESOURCE_DisplayText then exit;
  st.Free;

  savedialog := TSaveDialog.Create(nil);
  savedialog.FileName := TreeView1.Selected.Text;
  if savedialog.Execute then
  begin
    ImageResourceDataEntry := TreeView1.Selected.Data;
    DataLen := GetResourceSize(ImageResourceDataEntry);
    buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

    mem := TMemoryStream.Create;
    mem.Write(buf^, DataLen);
    mem.SaveToFile(savedialog.FileName);
    mem.Free;
  end;
  savedialog.Free;
end;

procedure TFMain.ToolButton1Click(Sender: TObject);
var
  lpTemplate: PDlgTemplate;
  rect: Trect;
begin
  if not Assigned(tv_dlg.Selected) then exit;
  if not Assigned(tv_dlg.Selected.Data) then Exit;
  if Assigned(tv_dlg.Selected.Parent) then Exit;
  if DialogWinHandle <> 0 then
  begin
    DestroyWindow(DialogWinHandle);
    DialogWinHandle := 0;
  end;
  lpTemplate := GetResourceDataPointer(pBaseAddress, TreeView1.Selected.Data, ResourcefRva);
  DialogWinHandle := CreateDialogIndirectParamA(0, lpTemplate^,
    0, @Win_DialogProc2, 0);
  if DialogWinHandle = 0 then
  begin
    MessageBox(Handle, Pchar('创建窗口失败：' + sysErrormessage(getlasterror)), '错误', MB_OK + MB_ICONSTOP);
  end;

  rect.Left := 0;
  rect.Top := 0;
  rect.Bottom := 50;
  rect.Right := 50;

  MapDialogRect(DialogWinHandle, rect);

  ShowWindow(DialogWinHandle, SW_SHOW);

end;

procedure TFMain.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  actionId: DWORD;
begin
  SetResInfo('Data:%d(%.8X)', [DWORD(TreeView1.Selected.data), DWORD(TreeView1.Selected.data)]);

  btn_saveBin.Enabled := False; //允许保存内容
  if Assigned(TreeView1.Selected) then
  begin
    actionId := DWORD(TreeView1.Selected.Data);

    if TreeView1.Selected.HasChildren then
    begin
      //默认显示所有子集
      DisplayChild(TreeView1.Selected);

    end else
      if (actionId = TREE_RESOURCE_NEEDLINK_ICON) or (actionId = TREE_RESOURCE_NEEDLINK_Cursor) then
      begin
        SetResInfo('等待链接的资源。。。');


      end else
        if actionId = TREE_EXEHEADER then
        begin
          DisplayDosHeader(dosHeader, ListView1);
          ShowContextControl(Cc_List);
        end else if actionId = TREE_COFFHEADER then
        begin
          DisplayCoffHeader(pBaseAddress, ListView1);
          ShowContextControl(Cc_List);
        end else if actionId = TREE_OPTHEADER then
        begin
          DisplayOptionalHeader(pBaseAddress, ListView1);
          ShowContextControl(Cc_List);
        end else

          if Assigned(TreeView1.Selected.Parent) and //区段
            (DWORD(TreeView1.Selected.Parent.Data) = TREE_SECTHEADER) then
          begin
            DisplaySectionContext(TreeView1.Selected.Data, pBaseAddress, ListView1);
            ShowContextControl(Cc_List);
          end else
            if Assigned(TreeView1.Selected.Parent) and //导出表
              (DWORD(TreeView1.Selected.Parent.Data) = TREE_EXPORT) then
            begin
              DisplayExportFuncList(pBaseAddress, TreeView1.Selected.Data, ExportfRva, ListView1);
              ShowContextControl(Cc_List);
            end else
              if Assigned(TreeView1.Selected.Parent) and //导入表
                (DWORD(TreeView1.Selected.Parent.Data) = TREE_IMPORT) then
              begin
                DisplayImportFuncList(pBaseAddress, TreeView1.Selected.Data, ImportfRva, ListView1);
                ShowContextControl(Cc_List);
              end else

                if Assigned(TreeView1.Selected.Parent) then begin
      //资源
                  if PosNodeIsParent(TREE_RESOURCE_DisplayText, TreeView1.Selected) then
                  begin
                    DisplayResource(TreeView1.Selected);
                  end;
                end;
  end;
end;

procedure TFMain.tv_dlgChange(Sender: TObject; Node: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
  PdtEx: PDlgTemplateEx;
  PdtEx2: PDlgTemplateEx2;

  PdtItem: PDlgItemTemplate;
  PdtItemEx: PDlgItemTemplateEx;

  TmpStr, TmpStr2: string;
  TmpPnt: Pointer;
  TmpDWORD: DWORD;
begin
  if not Assigned(tv_dlg.Selected) then exit;
  if not Assigned(tv_dlg.Selected.Data) then Exit;
  if not Assigned(tv_dlg.Selected.Parent) then //是窗体对象
  begin
    ImageResourceDataEntry := treeview1.Selected.Data;
    DataLen := ImageResourceDataEntry.Size;
    DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

    PdtEx := PDlgTemplateEx(DataOffset);
    if (PdtEx.dlgVer = 1) and (PdtEx.signature = $FFFF) then
    begin
      edt_dlg_X.Text := IntToStr(PdtEx.x);
      edt_dlg_Y.Text := IntToStr(PdtEx.y);
      edt_dlg_width.Text := IntToStr(PdtEx.cx);
      edt_dlg_Height.Text := IntToStr(PdtEx.cy);

      edt_dlg_menu.Text := IntToStr(PdtEx.menu);
      edt_dlg_ClassName.Text := IntToStr(PdtEx.windowClass);
      edt_dlg_title.Text := WideCharToString(@PdtEx.title);

      PdtEx2 := Pointer(Cardinal(@PdtEx.title) + Length(Widestring(edt_dlg_title.Text)) * 2 + 2);
      edt_dlg_font.Text := WideCharToString(@PdtEx2.typeface);
      edt_dlg_fontSize.Text := IntToStr(PdtEx2.pointsize);
      edt_dlg_fontweight.Text := IntToStr(PdtEx2.weight);
      edt_dlg_fontItalic.ItemIndex := PdtEx2.italic;
      edt_dlg_charset.Text := IntToStr(PdtEx2.charset); //ANSI_CHARSET

      display_style_Windows(PdtEx.Style, true);
      display_style_Ex_Windows(PdtEx.exStyle);
      //特有属性
      display_style_Dialog(PdtEx.Style);
    end;
  end else begin //是子对象，按钮啊，文本框啊什么的
    PdtItemEx := Node.Data;

    edt_dlg_X.Text := IntToStr(PdtItemEx.x);
    edt_dlg_Y.Text := IntToStr(PdtItemEx.y);
    edt_dlg_width.Text := IntToStr(PdtItemEx.cx);
    edt_dlg_Height.Text := IntToStr(PdtItemEx.cy);

    if LOWORD(PdtItemEx.windowClass) = $FFFF then //预定义
    begin
      case HiWord(PdtItemEx.windowClass) of
        $0080: TmpStr := 'Button';
        $0081: TmpStr := 'Edit';
        $0082: TmpStr := 'Static';
        $0083: TmpStr := 'Listbox';
        $0084: TmpStr := 'Scrollbar';
        $0085: TmpStr := 'Combobox';
      else
        TmpStr := 'UNKNOWN predefined';
      end;
      TmpPnt := @PdtItemEx.title;
    end else begin
      TmpStr := WideCharToString(@PdtItemEx.windowClass);
      TmpPnt := AlignToDword(Cardinal(@PdtItemEx.windowClass) + Length(Widestring(TmpStr)) * 2 + 2);
    end;

    if LOWORD(PDWORD(TmpPnt)^) = $FFFF then //资源id
    begin
      TmpStr2 := IntToHex(HiWord(PDWORD(TmpPnt)^), 4);
      TmpDWORD := Sizeof(Dword);
    end else begin
      TmpStr2 := WideCharToString(TmpPnt);
      TmpDWORD := Length(Widestring(TmpStr2)) * 2;
    end;
    edt_dlg_title.Text := TmpStr2;

    display_style_Windows(PdtItemEx.Style, false);
    display_style_Ex_Windows(PdtItemEx.exStyle);
    //控件
    display_style_ControlStyles(PdtItemEx.Style, TmpStr);

  end;
end;

procedure TFMain.display_style_Ex_Windows(style: DWORD);
const
  WS_EX_NOREDIRECTIONBITMAP = $00200000;
begin
  cb_dlg_style_EX_RIGHT.checked := (style and ws_EX_RIGHT) > 0;
  cb_dlg_style_EX_CLIENTEDGE.checked := (style and ws_EX_CLIENTEDGE) > 0;
  cb_dlg_style_EX_TRANSPARENT.checked := (style and ws_EX_TRANSPARENT) > 0;
  cb_dlg_style_EX_MDICHILD.checked := (style and ws_EX_MDICHILD) > 0;
  cb_dlg_style_EX_DLGMODALFRAME.checked := (style and ws_EX_DLGMODALFRAME) > 0;
  cb_dlg_style_EX_LEFTSCROLLBAR.checked := (style and ws_EX_LEFTSCROLLBAR) > 0;
  cb_dlg_style_EX_CONTEXTHELP.checked := (style and ws_EX_CONTEXTHELP) > 0;
  cb_dlg_style_EX_WINDOWEDGE.checked := (style and ws_EX_WINDOWEDGE) > 0;
  cb_dlg_style_EX_ACCEPTFILES.checked := (style and ws_EX_ACCEPTFILES) > 0;
  cb_dlg_style_EX_NOPARENTNOTIFY.checked := (style and ws_EX_NOPARENTNOTIFY) > 0;
  cb_dlg_style_EX_TOPMOST.checked := (style and ws_EX_TOPMOST) > 0;
  cb_dlg_style_EX_TOOLWINDOW.checked := (style and ws_EX_TOOLWINDOW) > 0;
  cb_dlg_style_EX_RTLREADING.checked := (style and ws_EX_RTLREADING) > 0;
  cb_dlg_style_EX_CONTROLPARENT.checked := (style and ws_EX_CONTROLPARENT) > 0;
  cb_dlg_style_EX_APPWINDOW.checked := (style and ws_EX_APPWINDOW) > 0;
  cb_dlg_style_EX_LAYOUTRTL.checked := (style and ws_EX_LAYOUTRTL) > 0;
  cb_dlg_style_EX_NOINHERITLAYOUT.checked := (style and ws_EX_NOINHERITLAYOUT) > 0;
  cb_dlg_style_EX_COMPOSITED.checked := (style and ws_EX_COMPOSITED) > 0;
  cb_dlg_style_EX_STATICEDGE.checked := (style and ws_EX_STATICEDGE) > 0;
  cb_dlg_style_EX_LAYERED.checked := (style and ws_EX_LAYERED) > 0;
  cb_dlg_style_EX_NOACTIVATE.checked := (style and ws_EX_NOACTIVATE) > 0;
  cb_dlg_style_EX_NOREDIRECTIONBITMAP.checked := (style and ws_EX_NOREDIRECTIONBITMAP) > 0;
end;

procedure TFMain.display_style_Windows(style: DWORD; isWindow: boolean);
begin
  cb_dlg_style_BORDER.checked := (style and ws_BORDER) > 0;
  cb_dlg_style_SIZEBOX.checked := (style and ws_SIZEBOX) > 0;
  cb_dlg_style_DLGFRAME.checked := (style and ws_DLGFRAME) > 0;
  cb_dlg_style_SYSMENU.checked := (style and ws_SYSMENU) > 0;
  cb_dlg_style_MINIMIZEBOX.checked := (style and ws_MINIMIZEBOX) > 0;
  cb_dlg_style_MAXIMIZEBOX.checked := (style and ws_MAXIMIZEBOX) > 0;
  cb_dlg_style_VISIBLE.checked := (style and ws_VISIBLE) > 0;
  cb_dlg_style_DISABLED.checked := (style and ws_DISABLED) > 0;
  cb_dlg_style_Caption.checked := (style and ws_Caption) > 0;
  cb_dlg_style_HSCROLL.checked := (style and ws_HSCROLL) > 0;
  cb_dlg_style_VSCROLL.checked := (style and ws_VSCROLL) > 0;
  cb_dlg_style_CLIPSIBLINGS.checked := (style and ws_CLIPSIBLINGS) > 0;
  cb_dlg_style_CLIPCHILDREN.checked := (style and ws_CLIPCHILDREN) > 0;

  if (style and WS_MINIMIZE) > 0 then
  begin
    cb_dlg_style_winState.ItemIndex := 1;
  end else if (style and WS_MAXIMIZE) > 0 then
  begin
    cb_dlg_style_winState.ItemIndex := 2;
  end else begin
    cb_dlg_style_winState.ItemIndex := 0;
  end;

  if (style and WS_POPUP) > 0 then
  begin
    cb_dlg_style_livestyle.ItemIndex := 0;
  end else if (style and WS_CHILD) > 0 then
  begin
    cb_dlg_style_livestyle.ItemIndex := 1;
  end else begin
    cb_dlg_style_livestyle.ItemIndex := 2;
  end;

end;

procedure TFMain.display_style_Dialog(style: DWORD);
begin
  ts_dialogstyle.TabVisible := True;
  ts_ControlStyles.TabVisible := False;

  cb_dlg_style_DS_3DLOOK.checked := (style and DS_3DLOOK) > 0;
  cb_dlg_style_DS_CENTERMOUSE.checked := (style and DS_CENTERMOUSE) > 0;
  cb_dlg_style_DS_ABSALIGN.checked := (style and DS_ABSALIGN) > 0;
  cb_dlg_style_DS_CENTER.checked := (style and DS_CENTER) > 0;
  cb_dlg_style_DS_CONTEXTHELP.checked := (style and DS_CONTEXTHELP) > 0;
  cb_dlg_style_DS_CONTROL.checked := (style and DS_CONTROL) > 0;
  cb_dlg_style_DS_FIXEDSYS.checked := (style and DS_FIXEDSYS) > 0;
  cb_dlg_style_DS_LOCALEDIT.checked := (style and DS_LOCALEDIT) > 0;
  cb_dlg_style_DS_MODALFRAME.checked := (style and DS_MODALFRAME) > 0;
  cb_dlg_style_DS_NOFAILCREATE.checked := (style and DS_NOFAILCREATE) > 0;
  cb_dlg_style_DS_NOIDLEMSG.checked := (style and DS_NOIDLEMSG) > 0;
  cb_dlg_style_DS_SETFONT.checked := (style and DS_SETFONT) > 0;
  cb_dlg_style_DS_SETFOREGROUND.checked := (style and DS_SETFOREGROUND) > 0;
  cb_dlg_style_DS_SYSMODAL.checked := (style and DS_SYSMODAL) > 0;
end;

procedure TFMain.display_style_ControlStyles_button(style: DWORD);
var
  btnType: Integer;
  Alignment: Integer;
begin
  btnType := style and $F;
  Alignment := style and $F00;

  cb_dlg_style_CS_Btn_type.ItemIndex := style and $F;

  if (Alignment and BS_CENTER) > 0 then
  begin
    cb_dlg_style_CS_Btn_HA.ItemIndex := 2;
  end else if (Alignment and BS_LEFT) > 0 then
  begin
    cb_dlg_style_CS_Btn_HA.ItemIndex := 1;
  end else if (Alignment and BS_RIGHT) > 0 then
  begin
    cb_dlg_style_CS_Btn_HA.ItemIndex := 3;
  end else
    cb_dlg_style_CS_Btn_HA.ItemIndex := 0;

  if (Alignment and BS_VCENTER) > 0 then
  begin
    cb_dlg_style_CS_Btn_VA.ItemIndex := 2;
  end else if (Alignment and BS_TOP) > 0 then
  begin
    cb_dlg_style_CS_Btn_VA.ItemIndex := 1;
  end else if (Alignment and BS_BOTTOM) > 0 then
  begin
    cb_dlg_style_CS_Btn_VA.ItemIndex := 3;
  end else
    cb_dlg_style_CS_Btn_VA.ItemIndex := 0;

  cb_dlg_style_CS_Btn_BITMAP.Checked := (style and BS_BITMAP) > 0;
  cb_dlg_style_CS_Btn_ICON.Checked := (style and BS_ICON) > 0;
  cb_dlg_style_CS_Btn_FLAT.Checked := (style and BS_FLAT) > 0;
  cb_dlg_style_CS_Btn_LEFTTEXT.Checked := (style and BS_LEFTTEXT) > 0;
  cb_dlg_style_CS_Btn_MULTILINE.Checked := (style and BS_MULTILINE) > 0;
  cb_dlg_style_CS_Btn_NOTIFY.Checked := (style and BS_NOTIFY) > 0;
  cb_dlg_style_CS_Btn_PUSHLIKE.Checked := (style and BS_PUSHLIKE) > 0;
end;

procedure TFMain.display_style_ControlStyles_Edit(style: DWORD);
begin
  if (style and ES_CENTER) > 0 then
  begin
    cb_dlg_style_CS_Edt_Ag.ItemIndex := 1;
  end else if (style and ES_RIGHT) > 0 then
  begin
    cb_dlg_style_CS_Edt_Ag.ItemIndex := 2;
  end else
    cb_dlg_style_CS_Edt_Ag.ItemIndex := 0;

  cb_dlg_style_CS_Edt_AUTOHSCROLL.Checked := (style and ES_AUTOHSCROLL) > 0;
  cb_dlg_style_CS_Edt_AUTOVSCROLL.Checked := (style and ES_AUTOVSCROLL) > 0;
  cb_dlg_style_CS_Edt_LOWERCASE.Checked := (style and ES_LOWERCASE) > 0;
  cb_dlg_style_CS_Edt_MULTILINE.Checked := (style and ES_MULTILINE) > 0;
  cb_dlg_style_CS_Edt_NOHIDESEL.Checked := (style and ES_NOHIDESEL) > 0;
  cb_dlg_style_CS_Edt_NUMBER.Checked := (style and ES_NUMBER) > 0;
  cb_dlg_style_CS_Edt_OEMCONVERT.Checked := (style and ES_OEMCONVERT) > 0;
  cb_dlg_style_CS_Edt_PASSWORD.Checked := (style and ES_PASSWORD) > 0;
  cb_dlg_style_CS_Edt_READONLY.Checked := (style and ES_READONLY) > 0;
  cb_dlg_style_CS_Edt_UPPERCASE.Checked := (style and ES_UPPERCASE) > 0;
  cb_dlg_style_CS_Edt_WANTRETURN.Checked := (style and ES_WANTRETURN) > 0;
end;

procedure TFMain.display_style_ControlStyles_Static(style: DWORD);
const
  SS_REALSIZECONTROL = $40;
var
  SS_TYPE: Dword;
  ellipsis: DWORD;
begin
  SS_TYPE := style and SS_TYPEMASK;
  ellipsis := style and SS_ELLIPSISMASK;
//  SS_LEFT = 0;
//  SS_CENTER = 1;
//  SS_RIGHT = 2;
//  SS_ICON = 3;
//  SS_BLACKRECT = 4;
//  SS_GRAYRECT = 5;
//  SS_WHITERECT = 6;
//  SS_BLACKFRAME = 7;
//  SS_GRAYFRAME = 8;
//  SS_WHITEFRAME = 9;
//  SS_USERITEM = 10;
//  SS_SIMPLE = 11;
//  SS_LEFTNOWORDWRAP = 12;
//  SS_BITMAP = 14;
//  SS_OWNERDRAW = 13;
//  SS_ENHMETAFILE = 15;
//  SS_ETCHEDHORZ = 16;
//  SS_ETCHEDVERT = 17;
//  SS_ETCHEDFRAME = 18;
  cb_dlg_style_CS_SS_type.ItemIndex := SS_TYPE;

  if ellipsis = SS_ENDELLIPSIS then
  begin
    cb_dlg_style_CS_SS_Ell.ItemIndex := 1;
  end else if ellipsis = SS_PATHELLIPSIS then
  begin
    cb_dlg_style_CS_SS_Ell.ItemIndex := 2;
  end else if ellipsis = SS_WORDELLIPSIS then
  begin
    cb_dlg_style_CS_SS_Ell.ItemIndex := 3;
  end else
    cb_dlg_style_CS_SS_Ell.ItemIndex := 0;

  cb_dlg_style_CS_SS_NOPREFIX.Checked := (style and SS_NOPREFIX) > 0;
  cb_dlg_style_CS_SS_NOTIFY.Checked := (style and SS_NOTIFY) > 0;
  cb_dlg_style_CS_SS_CENTERIMAGE.Checked := (style and SS_CENTERIMAGE) > 0;
  cb_dlg_style_CS_SS_RIGHTJUST.Checked := (style and SS_RIGHTJUST) > 0;
  cb_dlg_style_CS_SS_REALSIZEIMAGE.Checked := (style and SS_REALSIZEIMAGE) > 0;
  cb_dlg_style_CS_SS_SUNKEN.Checked := (style and SS_SUNKEN) > 0;
  cb_dlg_style_CS_SS_REALSIZECONTROL.Checked := (style and SS_REALSIZECONTROL) > 0;
end;

procedure TFMain.display_style_ControlStyles(style: DWORD; ControlType: string);
begin
  ts_dialogstyle.TabVisible := False;
  ts_ControlStyles.TabVisible := True;

  cb_dlg_style_CS_type.Text := ControlType;
  cb_dlg_style_CS_value.Text := IntToHex(style, 8);

  if ControlType = 'Button' then
  begin
    display_style_ControlStyles_button(style);
  end else if ControlType = 'Edit' then
  begin
    display_style_ControlStyles_Edit(style);
  end else if ControlType = 'Static' then
  begin
    display_style_ControlStyles_Static(style);
  end else if ControlType = 'Listbox' then
  begin

  end else if ControlType = 'Scrollbar' then
  begin

  end else if ControlType = 'Combobox' then
  begin

  end else
  begin
    cb_dlg_style_CS_type.Text := ControlType;
    cb_dlg_style_CS_value.Text := IntToHex(style, 8);
  end;
end;

procedure TFMain.tv_dlgDblClick(Sender: TObject);
var
  lpTemplate: PDlgTemplate;
begin
  if not Assigned(tv_dlg.Selected) then exit;
  if not Assigned(tv_dlg.Selected.Data) then Exit;
  if Assigned(tv_dlg.Selected.Parent) then Exit;
  if DialogWinHandle <> 0 then
  begin
    DestroyWindow(DialogWinHandle);
    DialogWinHandle := 0;
  end;
  lpTemplate := GetResourceDataPointer(pBaseAddress, TreeView1.Selected.Data, ResourcefRva);
  DialogWinHandle := CreateDialogIndirectParamA(0, lpTemplate^,
    0, @Win_DialogProc, 0);
  if DialogWinHandle = 0 then
  begin
    MessageBox(Handle, Pchar('创建窗口失败：' + sysErrormessage(getlasterror)), '错误', MB_OK + MB_ICONSTOP);
  end;
  ShowWindow(DialogWinHandle, SW_SHOW);

  (Sender as TtreeView).FullExpand;
end;

procedure TFMain.tv_menutreeChange(Sender: TObject; Node: TTreeNode);
var
  resInfo: Word;
  //Ex
  MenuEx:PPopUpMenuItem;
  _type :DWORD;
  state:DWORD;
begin
  if (Sender as TTreeView).Tag =0 then  //普通菜单
  begin
    resInfo := PWord(Node.Data)^;
    cb_Menu_ExtMenu.Checked := False;

    cb_Menu_Checked.Checked := (resInfo and MF_CHECKED) > 0;
    cb_Menu_RIGHTORDER.Checked := (resInfo and MFT_RIGHTORDER) > 0;
    cb_Menu_POPUP.Checked := (resInfo and MF_POPUP) > 0;
    cb_Menu_Grayed.Checked := (resInfo and MF_Grayed) > 0;
    cb_Menu_APPEND.Checked := (resInfo and MF_APPEND) > 0;
    cb_Menu_bitmap.Checked := (resInfo and MF_BITMAP) > 0;
    cb_Menu_MENUBREAK.Checked := (resInfo and MF_MENUBREAK) > 0;
    cb_Menu_DISABLED.Checked := (resInfo and MF_DISABLED) > 0;
    cb_Menu_Default.Checked := (resInfo and MF_Default) > 0;
    cb_Menu_MENUBARBREAK.Checked := (resInfo and MF_MENUBARBREAK) > 0;
    cb_Menu_END.Checked := (resInfo and MF_END) > 0;
    cb_Menu_RIGHTJUSTIFY.Checked := (resInfo and MF_RIGHTJUSTIFY) > 0;
    cb_Menu_MOUSESELECT.Checked := (resInfo and MF_MOUSESELECT) > 0;
    cb_Menu_DELETE.Checked := (resInfo and MF_DELETE) > 0;
    cb_Menu_BYPOSITION.Checked := (resInfo and MF_BYPOSITION) > 0;
    cb_Menu_SEPARATOR.Checked := (resInfo and MF_SEPARATOR) > 0;
    //扩展菜单内容
    cb_Menu_OWNERDRAW.Checked := False;
    cb_Menu_HILITE.Checked := False;
    cb_Menu_RADIOCHECK.Checked := False;
  end else begin  //扩展菜单
    MenuEx := PPopUpMenuItem(Node.Data);
    cb_Menu_ExtMenu.Checked := True;

    cb_Menu_Checked.Checked := (resInfo and MFS_CHECKED) > 0;
    cb_Menu_RIGHTORDER.Checked := (MenuEx._type and MFT_RIGHTORDER) > 0;
    cb_Menu_POPUP.Checked := (MenuEx.resInfo and MFR_POPUP) > 0;
    cb_Menu_Grayed.Checked := (MenuEx.state and MFS_GRAYED) > 0;
    cb_Menu_APPEND.Checked := (resInfo and 0) > 0;
    cb_Menu_bitmap.Checked := (MenuEx._type and MFT_BITMAP) > 0;
    cb_Menu_MENUBREAK.Checked := (MenuEx._type and MFT_MENUBREAK) > 0;
    cb_Menu_DISABLED.Checked := (MenuEx.state and MFS_DISABLED) > 0;
    cb_Menu_Default.Checked := (MenuEx.state and MFS_DEFAULT) > 0;
    cb_Menu_MENUBARBREAK.Checked := (MenuEx._type and MFT_MENUBARBREAK) > 0;
    cb_Menu_END.Checked := (MenuEx.resInfo and MF_END) > 0;
    cb_Menu_RIGHTJUSTIFY.Checked := (MenuEx._type and MFT_RIGHTJUSTIFY) > 0;
    cb_Menu_MOUSESELECT.Checked := (resInfo and 0) > 0;
    cb_Menu_DELETE.Checked := (resInfo and 0) > 0;
    cb_Menu_BYPOSITION.Checked := (resInfo and 0) > 0;
    cb_Menu_SEPARATOR.Checked := (MenuEx._type and MFT_SEPARATOR) > 0;

    cb_Menu_OWNERDRAW.Checked := (MenuEx._type and MFT_OWNERDRAW) > 0;
    cb_Menu_HILITE.Checked := (MenuEx.state and MFS_HILITE) > 0;
    cb_Menu_RADIOCHECK.Checked := (MenuEx._type and MFT_RADIOCHECK) > 0;
  end;
end;

procedure TFMain.DisplayChild(Node: TTreeNode);
var
  SubNode: TTreeNode;
begin
  ShowContextControl(Cc_Memo);
  Memo1.Hide;
  Memo1.Lines.Clear;
  SubNode := Node.getFirstChild;
  while Assigned(SubNode) do
  begin
    Memo1.Lines.Add(SubNode.Text);
    SubNode := Node.GetNextChild(SubNode);
  end;
  Memo1.Show;
end;

procedure TFMain.DisplayResource(TreeNode: TTreeNode);
var
  ParentNode: TTreeNode;
  st: Tlist;
begin
  st := Tlist.Create;
  ParentNode := TreeNode.Parent;
  while Assigned(ParentNode.Parent) and (ParentNode.Parent is TTreeNode) do
  begin
    st.Add(ParentNode);
    ParentNode := ParentNode.Parent;
  end;
  if ParentNode.Text <> TREE_RESOURCE_DisplayText then exit;
  st.Free;
  btn_saveBin.Enabled := true; //允许保存内容
//  _type : 0 默认，1 二进制, 2 文本，3 文本（宽字节）, 4 图片
  case ResDisplayType of
    Display_Default: DisplayResourceByDefault(TreeNode);
    Display_Bin: DisplayResourceByHex(TreeNode);
    Display_Ascii: DisplayResourceByTextAscsii(TreeNode);
    Display_Unicode: DisplayResourceByTextUnicode(TreeNode);
    Display_IMG: DisplayResourceByImg(TreeNode);
  end;
  SetResInfo(TreeNode);
end;

procedure TFMain.DisplayResourceByHex(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := GetResourceSize(ImageResourceDataEntry);
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  ShowContextControl(Cc_Memo);
  Memo1.Text := bytestostr(buf, DataLen, DWORD(ImageResourceDataEntry.Data - ResourcefRva));
end;

procedure TFMain.DisplayResourceByImg(TreeNode: TTreeNode);
const
  PngHeader = $474E5089;
  JpgHeader = $E1FFD8FF;
var
  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;

  MemBuf: TMemoryStream;
  png: TPNGObject;
  jpg: TJPEGImage;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := GetResourceSize(ImageResourceDataEntry);
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

  MemBuf := TMemoryStream.Create;
  MemBuf.Write(buf^, DataLen);
  MemBuf.Seek(0, soBeginning);

  if PDWORD(buf)^ = PngHeader then
  begin
    png := TPNGObject.Create;
    png.LoadFromStream(MemBuf);
    Image1.Picture.Bitmap.Assign(png);
    png.Free;
  end else if PDWORD(buf)^ = JpgHeader then
  begin
    jpg := TJPEGImage.Create;
    jpg.LoadFromStream(MemBuf);
    Image1.Picture.Bitmap.Assign(jpg);
    jpg.Free;
  end else begin
    ShowMessage('尚不支持的图片格式。。。');
  end;

  MemBuf.Free;
  ShowContextControl(Cc_Img);
end;

procedure TFMain.DisplayResourceByText(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := GetResourceSize(ImageResourceDataEntry);
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  ShowContextControl(Cc_Memo);

  if ResDisplayType = Display_Ascii then
  begin
    Memo1.Text := Pchar(buf);
  end else if ResDisplayType = Display_Unicode then
  begin
    Memo1.Text := PWideChar(buf);
  end else
    if StrByteType(Pchar(buf), DataLen) = mbSingleByte then
    begin
      Memo1.Text := Pchar(buf);
    end else begin
      Memo1.Text := PWideChar(buf);
    end;
end;

procedure TFMain.DisplayResourceByTextAscsii(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
  memstr: TStringStream;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := GetResourceSize(ImageResourceDataEntry);
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  ShowContextControl(Cc_Memo);

  memstr := TStringStream.Create('');
  memstr.Write(buf^, DataLen);
  if ((PDWORD(buf)^ and $FFFFFF) xor $00BFBBEF) = 0 then // 判断UTF-8 BOM
  begin
    Memo1.Text := UTF8Decode(memstr.DataString);
    StatusBar1.Panels[1].Text := 'UTF8  ';
  end else begin
    Memo1.Text := memstr.DataString;
    StatusBar1.Panels[1].Text := 'Ansi  ';
  end;
  memstr.Free;
end;

procedure TFMain.DisplayResourceByTextUnicode(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  buf: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
  memstr: TStringStream;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := GetResourceSize(ImageResourceDataEntry);
  buf := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  ShowContextControl(Cc_Memo);

  //Memo1.Text := PWideChar(buf);

  memstr := TStringStream.Create('');
  memstr.Write(buf^, DataLen);
  Memo1.Text := PWideChar(memstr.DataString);
  memstr.Free;
end;

procedure TFMain.DisplayResourceByDefault(TreeNode: TTreeNode);
var
  ParentNode: TTreeNode;
  st: Tlist;
begin
  st := Tlist.Create;
  st.Add(TreeNode);
  ParentNode := TreeNode.Parent;
  while Assigned(ParentNode.Parent) and (ParentNode.Parent is TTreeNode) do
  begin
    st.Add(ParentNode);
    ParentNode := ParentNode.Parent;
  end;
  if ParentNode.Text <> TREE_RESOURCE_DisplayText then exit;
  //执行到这里，ParentNode = '资源'节
  // st全部'资源'节子集
  if st.Count = 0 then Exit;
  ParentNode := st.Items[st.Count - 1];

  if ParentNode.Text = ResourceTypeName[rtString] then //字符串
  begin
    ParentNode := st.Items[st.Count - 2];
    GetResourceStringBlock(ParentNode.Text, TreeNode);
  end else if (ParentNode.Text = ResourceTypeName[rtBitmap]) then //位图
  begin
    GetResourceBmpBlock(TreeNode);
  end else if ParentNode.Text = ResourceTypeName[rtIcon] then //图标
  begin
    GetResourceIconOrCursor(TreeNode, rtIcon);
  end else if ParentNode.Text = ResourceTypeName[rtCursor] then //光标
  begin
    GetResourceIconOrCursor(TreeNode, rtCursor);
  end else if ParentNode.Text = ResourceTypeName[rtVersion] then //版本
  begin
    GetResourceVersion(TreeNode);
  end else if ParentNode.Text = ResourceTypeName[rtDialog] then //对话框
  begin
    GetResourceDialog(TreeNode);
  end else if ParentNode.Text = ResourceTypeName[rtMenu] then //菜单
  begin
    GetResourceMenu(TreeNode);
  end else begin
    DisplayResourceByHex(TreeNode);
  end;

  st.Free;
end;

procedure TFMain.ChangeResDisplayWay(_type: TdisplayType);
begin
  ResDisplayType := _type;
  if btn_saveBin.Enabled then
  begin
    DisplayResource(TreeView1.Selected);
  end;
end;

procedure TFMain.CloseAndDestroy;
begin
  //关闭打开的文件
  TreeView1.Items.BeginUpdate;
  TreeView1.Items.Clear;
  TreeView1.Items.EndUpdate;
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;
  ListView1.Items.EndUpdate;
  Memo1.Clear;
  UnmapViewOfFile(pBaseAddress);
  CloseHandle(fileMap);
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  //OpenAndMapping('C:\Users\Chen\Desktop\DllFuncExporter\TestDll\Project1.dll');
  //OpenAndMapping('C:\Users\Chen\Desktop\DllFuncExporter\TestDll\HD300_V1.dll');
  //OpenAndMapping('C:\Users\Chen\Desktop\DllFuncExporter\TestDll\kernel64.dll');
  //OpenAndMapping('C:\Users\Chen\Desktop\DllFuncExporter\TestDll\XmpGuessRes.dll');
  //OpenAndMapping('C:\Users\Chen\Desktop\DllFuncExporter\TestDll\TeamViewer_Resource_en.dll');

  //支持文件拖入
  OldListWProc := TreeView1.WindowProc;
  TreeView1.WindowProc := NewListWProc;
  DragAcceptFiles(TreeView1.Handle, True);


end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  TreeView1.WindowProc := OldListWProc;
  DragAcceptFiles(TreeView1.Handle, False);
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  //
  ShowContextControl(Cc_Img);

end;

procedure TFMain.ListView1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  TmpHit: string;
begin
  if ListView1.GetItemAt(X, Y) <> nil then
  begin
    TmpHit := ListView1.GetItemAt(X, Y).SubItems[1]; //含意
    if Pos(',', TmpHit) > 0 then
    begin
      TmpHit := StringReplace(TmpHit, ',', #13#10, [rfIgnoreCase, rfReplaceAll]);
      (Sender as TListView).Hint := TmpHit;
    end;
  end;
end;

procedure TFMain.N11Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    ListView1.Font := FontDialog1.Font;
    TreeView1.Font := FontDialog1.Font;
    Memo1.Font := FontDialog1.Font;
  end;
end;

procedure TFMain.N12Click(Sender: TObject);
begin
  //
  n7.Checked := false;
  n8.Checked := false;
  n9.Checked := false;
  n12.Checked := false;
  N13.Checked := false;

  (Sender as TMenuItem).checked := True;
  if n7.Checked then
  begin
    ChangeResDisplayWay(Display_Default);
  end else if n8.Checked then
  begin
    ChangeResDisplayWay(Display_Bin);
  end else if n9.Checked then
  begin
    ChangeResDisplayWay(Display_Ascii);
  end else if n12.Checked then
  begin
    ChangeResDisplayWay(Display_Unicode);
  end else if n13.Checked then
  begin
    ChangeResDisplayWay(Display_IMG);
  end else begin

  end;
end;

procedure TFMain.N2Click(Sender: TObject);
var
  opendialog: TOpenDialog;
begin
  opendialog := TOpenDialog.Create(nil);
  try
    opendialog.Filter := '可执行文件(*.dll;*.exe)|*.dll;*.exe';
    if opendialog.Execute then
    begin
      OpenAndMapping(opendialog.FileName)
    end;
  finally
    opendialog.free;
  end;
end;

procedure TFMain.N4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFMain.GetResourceStringBlock(BlockName: string; TreeNode: TTreeNode);
const
  StringsPerBlock = 16; //每一块最多有的字符串条数
var
  P: PWChar;
  ID: Integer;
  Cnt: integer;
  Len: Word;
  S: string;
  I: Integer;

  ImageResourceDataEntry: PImageResourceDataEntry;
begin
  ImageResourceDataEntry := TreeNode.Data;
  P := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

  S := '';
  if TryStrToInt(BlockName, Cnt) then
  begin
    Cnt := (Cnt - 1) shl 4;
    for I := 0 to StringsPerBlock - 1 do
    begin
      Len := Word(P^);
      if Len > 0 then
      begin
        Inc(P);
        ID := Cnt + i;
        S := S + Format('%d, "%s"'#$D#$A, [ID, WideCharLenToString(P, Len)]);
        Inc(P, Len);
      end else begin
        Inc(P);
      end;
    end;
  end;
  ShowContextControl(Cc_Memo);
  Memo1.Text := S;
end;

procedure TFMain.GetResourceBmpBlock(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;

  Bfh: TBitmapFileHeader; //位图文件头信息
  Bih: PBitmapInfoHeader;

  bmpStream: TMemoryStream;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := ImageResourceDataEntry.Size;
  DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  //资源文件的位图是去掉了 bmp头的
  Bfh.bfType := $4D42;
  Bfh.bfSize := SizeOf(TBitmapFileHeader) + DataLen;

  Bih := DataOffset;
  //16位、24位和32位色 不包含调色板信息
  if Bih.biBitCount >= 16 then
  begin
    ShowMessage('Untested way。。。。Bih.biBitCount >= 16');
    Bfh.bfOffBits := SizeOf(Bfh) + SizeOf(TBitmapInfoHeader);
  end else begin
    Bfh.bfOffBits := SizeOf(Bfh) + SizeOf(TBitmapInfoHeader) +
      (2 shl Bih.biBitCount) * SizeOf(DWORD);
  end;

  bmpStream := TMemoryStream.create;

  bmpStream.Write(Bfh, SizeOf(Bfh));
  bmpStream.Write(DataOffset^, DataLen);
  bmpStream.Seek(0, 0);

  Image1.Picture.Bitmap.LoadFromStream(bmpStream);
  bmpStream.Free;
  ShowContextControl(Cc_Img);
end;

procedure TFMain.GetResourceIconOrCursor(TreeNode: TTreeNode; _type: ResourceType);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;

  icon: TIcon;
  ficon: Boolean;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := ImageResourceDataEntry.Size;
  DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

  ficon := _type = rtIcon;

  icon := TIcon.Create;
  try
    icon.Handle := CreateIconFromResourceEX(Pbyte(DataOffset), DataLen, ficon, $30000, 0, 0, LR_DEFAULTCOLOR);
    Image1.Picture.Icon.Assign(icon);
  finally
    icon.Free;
  end;
  ShowContextControl(Cc_Img);
end;

procedure TFMain.GetResourceVersion(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
  pvs: PVS_VERSIONINFO;

  TmpDWORD: DWORD;
  TmpStr, TmpStr2: string;
  TmpPnt: Pointer;

  PSI: PStringFileInfo;
  PST: PStringTable;
  PAS: PAString;
  PVI: PVarFileInfo;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := ImageResourceDataEntry.Size;
  DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  pvs := PVS_VERSIONINFO(DataOffset);

  //版本
  edt_ver_BinaryVersion.Text := Format('%d. %d', [HiWord(pvs.Value.dwStrucVersion),
    LOWORD(pvs.Value.dwStrucVersion)]);
  edt_ver_fileVersion.Text := Format('%d. %d. %d. %d', [HiWord(pvs.Value.dwFileVersionMS),
    LOWORD(pvs.Value.dwFileVersionMS),
      HiWord(pvs.Value.dwFileVersionLS),
      LOWORD(pvs.Value.dwFileVersionLS)]);
  edt_ver_productVersion.Text := Format('%d. %d. %d. %d', [HiWord(pvs.Value.dwProductVersionMS),
    LOWORD(pvs.Value.dwProductVersionMS),
      HiWord(pvs.Value.dwProductVersionLS),
      LOWORD(pvs.Value.dwProductVersionLS)]);
  //文件系统
  TmpDWORD := pvs.Value.dwFileOS;
  TmpStr := '';
  if TmpDWORD = VOS__WINDOWS16 then
  begin
    TmpStr := 'VOS__WINDOWS16';
  end else if TmpDWORD = VOS__PM16 then
  begin
    TmpStr := 'VOS__PM16';
  end else if TmpDWORD = VOS__PM32 then
  begin
    TmpStr := 'VOS__PM32';
  end else if TmpDWORD = VOS__WINDOWS32 then
  begin
    TmpStr := 'VOS__WINDOWS32';
  end else if TmpDWORD = VOS_DOS_WINDOWS16 then
  begin
    TmpStr := 'VOS_DOS_WINDOWS16';
  end else if TmpDWORD = VOS_DOS_WINDOWS32 then
  begin
    TmpStr := 'VOS_DOS_WINDOWS32';
  end else if TmpDWORD = VOS_OS216_PM16 then
  begin
    TmpStr := 'VOS_OS216_PM16';
  end else if TmpDWORD = VOS_OS232_PM32 then
  begin
    TmpStr := 'VOS_OS232_PM32';
  end else if TmpDWORD = VOS_NT_WINDOWS32 then
  begin
    TmpStr := 'VOS_NT_WINDOWS32';
  end else
    TmpStr := Format('VOS_Unknown: %.8X', [TmpDWORD]);

  edt_ver_OS.Text := TmpStr;
  //文件类型
  case pvs.Value.dwFileType of
    VFT_UNKNOWN: edt_ver_filetype.Text := 'VFT_UNKNOWN';
    VFT_APP: edt_ver_filetype.Text := 'VFT_APP';
    VFT_DLL: edt_ver_filetype.Text := 'VFT_DLL';
    VFT_DRV: edt_ver_filetype.Text := 'VFT_DRV';
    VFT_FONT: edt_ver_filetype.Text := 'VFT_FONT';
    VFT_VXD: edt_ver_filetype.Text := 'VFT_VXD';
    VFT_STATIC_LIB: edt_ver_filetype.Text := 'VFT_STATIC_LIB';
  end;
  //文件子系统
  edt_ver_subSystype.Text := IntToStr(pvs.Value.dwFileSubtype);
  //文件标记
  cb_ver_ff_debug.Checked := pvs.Value.dwFileFlags and VS_FF_DEBUG > 0;
  cb_ver_ff_preRelease.Checked := pvs.Value.dwFileFlags and VS_FF_PRERELEASE > 0;
  cb_ver_ff_infoinferred.Checked := pvs.Value.dwFileFlags and VS_FF_INFOINFERRED > 0;
  cb_ver_ff_patched.Checked := pvs.Value.dwFileFlags and VS_FF_PATCHED > 0;
  cb_ver_ff_privateBuild.Checked := pvs.Value.dwFileFlags and VS_FF_PRIVATEBUILD > 0;
  cb_ver_ff_specialBuild.Checked := pvs.Value.dwFileFlags and VS_FF_SPECIALBUILD > 0;

  lv_ver.Clear;
  //根据内容长度判断是否包含 StringFileInfo字段
  PSI := @pvs.StringFileInfo;
  if pvs.wLength > (Cardinal(PSI) - Cardinal(@pvs.wLength)) then
  begin
    lv_ver.Items.Add.Caption := 'StringFileInfo';
    //循环读取语言目录
    Pst := @PSI.Children;
    while PSI.wLength > (Cardinal(Pst) - Cardinal(@PSI.wLength)) do
    begin
      Tmpstr := WideCharToString(@pst.szKey);
      lv_ver.Items.Add.Caption := Format('    %s', [Tmpstr]); ;
      //循环读取字符串数据
      PAS := @Pst.Children;
      while Pst.wLength > (Cardinal(PAS) - Cardinal(@Pst.wLength)) do
      begin
        Tmpstr := WideCharToString(@PAS.szKey);
        TmpDWORD := Cardinal(@PAS.szKey) + Length(Tmpstr) * 2 + 2;
        //StringFileInfo中的结构不是标准的 C结构体，每一个数据起点都是32位对齐的
        Tmpstr2 := WideCharLenToString(AlignToDword(TmpDWORD), PAS.wValueLength);

        with lv_ver.Items.Add do
        begin
          Caption := '        ' + TmpStr;
          SubItems.Add(TmpStr2);
        end;
        PAS := AlignToDword(Cardinal(PAS) + PAS.wLength);
      end;
      Pst := AlignToDword(Cardinal(Pst) + Pst.wLength); //?
    end;
    //StringFileInfo 下面紧跟的是 VarFileInfo
    PVI := AlignToDword(Cardinal(PSI) + PSI.wLength);
    if pvs.wLength > (Cardinal(PVI) - Cardinal(@pvs.wLength)) then
    begin
      lv_ver.Items.Add.Caption := 'VarFileInfo';
      TmpStr := '';
      TmpPnt := @PVI.Children.Value;
      while PVI.Children.wValueLength > (Cardinal(TmpPnt) - Cardinal(@PVI.Children.Value)) do
      begin
        TmpStr := TmpStr + Format(',   %.4X %.4X', [LOWord(PDword(TmpPnt)^), HiWord(PDword(TmpPnt)^)]);
        TmpPnt := Pointer(Cardinal(TmpPnt) + 4); //language and code
      end;
      Delete(TmpStr, 1, 1); //删除第一个逗号
      with lv_ver.Items.Add do
      begin
        Caption := '    ' + 'Translation';
        SubItems.Add(TmpStr);
      end;
    end;
  end;
  ShowContextControl(Cc_VerSion)
end;

procedure TFMain.GetResourceDialog(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;

  node: TTreeNode;

  TmpStr, TmpStr2: string;
  TmpPnt: Pointer;
  TmpDWORD: DWORD;

  Pdt: PDlgTemplate;
  PdtEx: PDlgTemplateEx;
  PdtEx2: PDlgTemplateEx2;

  PdtItem: PDlgItemTemplate;
  PdtItemEx: PDlgItemTemplateEx;
  I: Integer;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := ImageResourceDataEntry.Size;
  DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);

  PdtEx := PDlgTemplateEx(DataOffset);
  if (PdtEx.dlgVer = 1) and (PdtEx.signature = $FFFF) then
  begin
    edt_dlg_X.Text := IntToStr(PdtEx.x);
    edt_dlg_Y.Text := IntToStr(PdtEx.y);
    edt_dlg_width.Text := IntToStr(PdtEx.cx);
    edt_dlg_Height.Text := IntToStr(PdtEx.cy);

    edt_dlg_menu.Text := IntToStr(PdtEx.menu);
    edt_dlg_ClassName.Text := IntToStr(PdtEx.windowClass);
    edt_dlg_title.Text := WideCharToString(@PdtEx.title);

    PdtEx2 := Pointer(Cardinal(@PdtEx.title) + Length(Widestring(edt_dlg_title.Text)) * 2 + 2);
    edt_dlg_font.Text := WideCharToString(@PdtEx2.typeface);
    edt_dlg_fontSize.Text := IntToStr(PdtEx2.pointsize);
    edt_dlg_fontweight.Text := IntToStr(PdtEx2.weight);
    edt_dlg_fontItalic.ItemIndex := PdtEx2.italic;
    edt_dlg_charset.Text := IntToStr(PdtEx2.charset); //ANSI_CHARSET

    tv_dlg.Items.Clear;

    TmpStr := 'Dialog: ' + TreeView1.Selected.Text;
    node := tv_dlg.Items.AddChildObject(nil, TmpStr, PdtEx2);

    PdtItemEx := AlignToDword(Cardinal(@PdtEx2.typeface) + Length(Widestring(edt_dlg_font.Text)) * 2 + 2);
    for I := 0 to PdtEx.cDlgItems - 1 do
    begin
      if LOWORD(PdtItemEx.windowClass) = $FFFF then //预定义
      begin
        case HiWord(PdtItemEx.windowClass) of
          $0080: TmpStr := 'Button';
          $0081: TmpStr := 'Edit';
          $0082: TmpStr := 'Static';
          $0083: TmpStr := 'Listbox';
          $0084: TmpStr := 'Scrollbar';
          $0085: TmpStr := 'Combobox';
        else
          TmpStr := 'UNKNOWN predefined';
        end;
        TmpPnt := @PdtItemEx.title;
      end else begin
        TmpStr := WideCharToString(@PdtItemEx.windowClass);
        TmpPnt := AlignToDword(Cardinal(@PdtItemEx.windowClass) + Length(Widestring(TmpStr)) * 2 + 2);
      end;

      if LOWORD(PDWORD(TmpPnt)^) = $FFFF then //资源id
      begin
        TmpStr2 := '  resId:$' + IntToHex(HiWord(PDWORD(TmpPnt)^), 4);
        TmpDWORD := Sizeof(Dword);
      end else begin
        TmpStr2 := WideCharToString(TmpPnt);
        TmpDWORD := Length(Widestring(TmpStr2)) * 2;
      end;
      if TmpStr = 'Button' then
        TmpStr := cb_dlg_style_CS_Btn_type.Items[PdtItemEx.style and $F];
      tv_dlg.Items.AddChildObject(node, TmpStr + ': ' + TmpStr2, PdtItemEx);

      PdtItemEx := AlignToDword(Cardinal(TmpPnt) + TmpDWORD +
        Sizeof(PdtItemEx.title) + Sizeof(PdtItemEx.extraCount));
    end;

    tv_dlg.Select(tv_dlg.Items[0], []);
    tv_dlgChange(tv_dlg, tv_dlg.Selected);

  end else begin
    Pdt := PDlgTemplate(DataOffset);

  end;

  tv_dlg.FullExpand;
  ShowContextControl(Cc_Dialog);


end;

procedure TFMain.GetResourceMenuList(Node: TTreeNode; var normalMenu: PNormalMenu);
var
  menuText: string;
  TmpNode: TTreeNode;
  MenuItem: PNormalMenuItem;
  resInfo: Word;
begin
  resInfo := normalMenu.resInfo;
  while True do
  begin
    if (resInfo and MF_POPUP) > 0 then //有子菜单标签的
    begin
      menuText := WideCharToString(@normalMenu.menuText);
      TmpNode := tv_menutree.Items.AddChildObject(Node, Format('%d,%s', [normalMenu.resInfo, menuText]), @normalMenu.resInfo);
      normalMenu := PNormalMenu(DWORD(normalMenu) + SizeOf(WORD) + Length(WideString(menuText)) * 2 + 2);

      GetResourceMenuList(TmpNode, normalMenu);
    end else begin
      MenuItem := Pointer(normalMenu);

      menuText := WideCharToString(@MenuItem.menuText);
      TmpNode := tv_menutree.Items.AddChildObject(Node, Format('%d,%s', [MenuItem.id, menuText]), @MenuItem.resInfo);
      normalMenu := PNormalMenu(dword(normalMenu) + sizeof(WORD) * 2 + Length(WideString(menuText)) * 2 + 2);
    end;
    if (resInfo and MF_END) > 0 then
    begin
      break;
    end;
    resInfo := normalMenu.resInfo;
  end;
end;

procedure TFMain.GetResourceMenuExList(Node: TTreeNode; var PopUpMenu: PPopUpMenuItem);
var
  menuText: string;
  TmpNode: TTreeNode;
  resInfo: Word;
begin
  resInfo := PopUpMenu.resInfo;
  while True do
  begin
    menuText := WideCharToString(@PopUpMenu.menuText);
    
    if (resInfo and MFR_POPUP) > 0 then //有子菜单标签的
    begin
      TmpNode := tv_menutree.Items.AddChildObject(Node, Format('%d,%s', [PopUpMenu.id, menuText]), PopUpMenu);

      PopUpMenu := PPopUpMenuItem(dword(PopUpMenu) + sizeof(TPopUpMenuItem) + Length(WideString(menuText)) * 2 + 2);
      PopUpMenu := AlignToDword(PopUpMenu);

      GetResourceMenuExList(TmpNode, PopUpMenu)
    end else begin
      TmpNode := tv_menutree.Items.AddChildObject(Node, Format('%d,%s', [PopUpMenu.id, menuText]), PopUpMenu);
      //Item 没有dwHelpId成员
      PopUpMenu := PPopUpMenuItem(dword(PopUpMenu) + sizeof(TPopUpMenuItem) + Length(WideString(menuText)) * 2 + 2 - Sizeof(Dword));
      PopUpMenu := AlignToDword(PopUpMenu);
    end;

    if (resInfo and MF_END) > 0 then
    begin
      break;
    end;
    resInfo := PopUpMenu.resInfo;
  end;
end;


procedure TFMain.GetResourceMenu(TreeNode: TTreeNode);
var
  DataLen: DWORD;
  DataOffset: Pointer;
  ImageResourceDataEntry: PImageResourceDataEntry;
  //普通菜单
  MenuHeader: PMenuHeader;
  normalMenu: PNormalMenu;
  //扩展菜单
  MenuExHeader: PMenuExTemplateHeader;
  PopItem:PPopUpMenuItem;
begin
  ImageResourceDataEntry := TreeNode.Data;
  DataLen := ImageResourceDataEntry.Size;
  DataOffset := GetResourceDataPointer(pBaseAddress, ImageResourceDataEntry, ResourcefRva);
  MenuHeader := DataOffset;
  MenuExHeader := DataOffset;

  tv_menutree.Items.Clear;

  if (MenuHeader.wVersion = 0) and
    (MenuHeader.cbHeaderSize = 0) then //普通菜单
  begin
    tv_menutree.Tag := 0;
    normalMenu := PNormalMenu(dword(MenuHeader) + sizeof(TMenuHeader));

    GetResourceMenuList(nil, normalMenu);
  end else
  if (MenuExHeader.wVersion = 1) and
     (MenuExHeader.wOffset = 4) then
  begin //扩展菜单
    tv_menutree.Tag := 1;
    PopItem := PPopUpMenuItem(dword(MenuHeader) + sizeof(TMenuExTemplateHeader));

    GetResourceMenuExList(nil, PopItem);
  end;

  if tv_menutree.Items.Count>0 then
    tv_menutree.Select(tv_menutree.Items[0],[]);

  tv_menutree.FullExpand;
  ShowContextControl(Cc_Menu);
end;

end.

