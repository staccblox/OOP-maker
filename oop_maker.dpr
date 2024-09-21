procedure Tf_MyFirstProjectMain.b_HelloClick(Sender: TObject);
var
  FirstName: string;
  Greeting: string;
begin
  FirstName := ed_FirstName.Text;
  Greeting := Format('Hello %s!', [FirstName]);
  MessageDlg(Greeting, mtInformation, [mbOK], 0);
end;
