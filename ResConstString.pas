unit ResConstString;

interface

const
  //�����б�
  TREE_HEADER = 1 ;   //ͷ
  TREE_EXEHEADER = 10;  //exeͷ
  TREE_COFFHEADER = 11; //coffͷ
  TREE_OPTHEADER = 12;  //��ѡͷ
  TREE_SECTHEADER = 13; //����ͷ
  
  TREE_EXPORT = 2; //����

  TREE_IMPORT = 3;  //����

  TREE_RESOURCE = 4;  //��Դ

  TREE_RESOURCE_NEEDLINK_ICON = $4444; //��Ҫ���ӵ�ͼ��
  TREE_RESOURCE_NEEDLINK_Cursor = $4445; //��Ҫ���ӵĹ��

resourcestring
  TREE_HEADER_DisplayText = 'ͷ��';
  TREE_EXPORT_DisplayText = '����';
  TREE_IMPORT_DisplayText = '����';
  TREE_RESOURCE_DisplayText = '��Դ';

implementation

end.
