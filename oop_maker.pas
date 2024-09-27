unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Windows, ActiveX, ComObj;

type

  { TForm1 }

  TForm1 = class(TForm, IDropTarget)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    // IDropTarget
    function DragEnter(const dataObj: IDataObject; grfKeyState: DWORD; pt: TPoint; var dwEffect: DWORD): HResult;StdCall;
    function DragOver(grfKeyState: DWORD; pt: TPoint; var dwEffect: DWORD): HResult;StdCall;
    function DragLeave: HResult;StdCall;
    function Drop(const dataObj: IDataObject; grfKeyState: DWORD; pt: TPoint; var dwEffect: DWORD):HResult;StdCall;
    // IUnknown
    // Ignore referance counting
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    { public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  OleInitialize(nil);
  OleCheck(RegisterDragDrop(Handle, Self));
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  RevokeDragDrop(Handle);
  OleUninitialize;
end;

function TForm1.DragEnter(const dataObj: IDataObject; grfKeyState: DWORD;
  pt: TPoint; var dwEffect: DWORD): HResult; StdCall;
begin
  dwEffect := DROPEFFECT_COPY;
  Result := S_OK;
end;

function TForm1.DragOver(grfKeyState: DWORD; pt: TPoint; var dwEffect: DWORD
  ): HResult; StdCall;
begin
  dwEffect := DROPEFFECT_COPY;
  Result := S_OK;
end;

function TForm1.DragLeave: HResult; StdCall;
begin
  Result := S_OK;
end;

function TForm1._AddRef: Integer; stdcall;
begin
   Result := 1;
end;

function TForm1._Release: Integer; stdcall;
begin
   Result := 1;
end;

function TForm1.Drop(const dataObj: IDataObject; grfKeyState: DWORD;
  pt: TPoint; var dwEffect: DWORD): HResult; StdCall;
var
  aFmtEtc: TFORMATETC;
  aStgMed: TSTGMEDIUM;
  pData: PChar;
begin
  {Make certain the data rendering is available}
  if (dataObj = nil) then
    raise Exception.Create('IDataObject-Pointer is not valid!');
  with aFmtEtc do
  begin
    cfFormat := CF_TEXT;
    ptd := nil;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL;
  end;
  {Get the data}
  OleCheck(dataObj.GetData(aFmtEtc, aStgMed));
  try
    {Lock the global memory handle to get a pointer to the data}
    pData := GlobalLock(aStgMed.hGlobal);
    { Replace Text }
    Memo1.Text := pData;
  finally
    {Finished with the pointer}
    GlobalUnlock(aStgMed.hGlobal);
    {Free the memory}
    ReleaseStgMedium(aStgMed);
  end;
  Result := S_OK;
end;


end.
