unit ResConstString;

interface

const
  //树型列表。
  TREE_HEADER = 1 ;   //头
  TREE_EXEHEADER = 10;  //exe头
  TREE_COFFHEADER = 11; //coff头
  TREE_OPTHEADER = 12;  //可选头
  TREE_SECTHEADER = 13; //区段头
  
  TREE_EXPORT = 2; //导出

  TREE_IMPORT = 3;  //导入

  TREE_RESOURCE = 4;  //资源

  TREE_RESOURCE_NEEDLINK_ICON = $4444; //需要链接的图标
  TREE_RESOURCE_NEEDLINK_Cursor = $4445; //需要链接的光标

resourcestring
  TREE_HEADER_DisplayText = '头部';
  TREE_EXPORT_DisplayText = '导出';
  TREE_IMPORT_DisplayText = '导入';
  TREE_RESOURCE_DisplayText = '资源';

implementation

end.
