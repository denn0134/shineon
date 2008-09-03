namespace ShineOn.Rtl;

interface

uses
  System.Collections,
  System.Collections.Generic,
  System.ComponentModel,
  System.Data,
  System.Text;

type
  EDatsetException = public class(Exception) end;
  TCDSState = public enum (dsBrowse=0, dsEdit=1, dsInactive=2, dsInsert=3);
  TCDSFields = public class
  private
    FDataSet: TCustomClientDataSet;
    FItems: List<TCDSField> := new List<TCDSField>;
  assembly
    method Invalidate;
  public 
    constructor Create(aDataset: TCustomClientDataSet);


    property Items[aIndex: Integer]: TCDSField read FItems[aIndex]; default;
    property Count: Integer read FItems.Count;
    method FieldByName(aFieldName: String): TCDSField;

    [Browsable(false)]
    property DataSet: TCustomClientDataSet read FDataSet;
  end;
  TFieldNotifyEvent = public procedure(Sender: TCDSField);
  TCDSField = public class
  private
    fOnChange: TFieldNotifyEvent;
    fOnValidate: TFieldNotifyEvent;
    FColumn: DataColumn;
    FDataset: TCustomClientDataSet;
    method get_Value: Object;
    method set_Value(aValue: Object);
  assembly
    method Row: DataRow;
    constructor (aDataset: TCustomClientDataSet;aColumn: DataColumn);
    property IntColumn: DataColumn read FColumn write FColumn;
  public 
   public method IsNull: Boolean;
    { Properties }
    [Browsable(false)]
    public property AsBoolean: Boolean read Convert.ToBoolean(Value) write Value;
    [Browsable(false)]
    public property AsInteger: Int32 read Convert.ToInt32(Value) write Value;
    [Browsable(false)]
    public property AsString: String read Convert.ToString(Value) write Value;
    [Browsable(false)]
    public property DataSet: TCustomClientDataSet read FDataset;
    [Browsable(false)]
    public property FieldName: String read FColumn.ColumnName write FColumn.ColumnName;
    [Browsable(false)]
    public property Value: Object read get_Value write set_Value;
    [Browsable(false)]
    property Column: DataColumn read FColumn;

    property OnValidate: TFieldNotifyEvent read fOnValidate write fOnValidate;
    property OnChange: TFieldNotifyEvent read fOnChange write fOnChange;
  end;

  TDataAction = public (daFail, daAbort, daRetry);
  TDataSetNotifyEvent = public procedure(DataSet: TCustomClientDataSet);
  TDataSetErrorEvent = public procedure(DataSet: TCustomClientDataSet; E: EDatsetException; var Action: TDataAction);
  // 
  TCustomClientDataSet = public abstract class(Component, IBindingListView, IBindingList, IList, ICollection, 
	IEnumerable, ITypedList, ISupportInitializeNotification, ISupportInitialize, ICancelAddNew,
	System.Windows.Forms.ICurrencyManagerProvider)
  private
    fLastRow: Integer := -1;
    fBeforeOpen: TDataSetNotifyEvent;
    fAfterOpen: TDataSetNotifyEvent;
    fBeforeClose: TDataSetNotifyEvent;
    fAfterClose: TDataSetNotifyEvent;
    //fBeforeInsert: TDataSetNotifyEvent;
    //fAfterInsert: TDataSetNotifyEvent;
    //fBeforeEdit: TDataSetNotifyEvent;
    //fAfterEdit: TDataSetNotifyEvent;
    fBeforePost: TDataSetNotifyEvent;
    fAfterPost: TDataSetNotifyEvent;
    fBeforeCancel: TDataSetNotifyEvent;
    fAfterCancel: TDataSetNotifyEvent;
    fBeforeDelete: TDataSetNotifyEvent;
    fAfterDelete: TDataSetNotifyEvent;
    fBeforeScroll: TDataSetNotifyEvent;
    fAfterScroll: TDataSetNotifyEvent;
    fBeforeRefresh: TDataSetNotifyEvent;
    fAfterRefresh: TDataSetNotifyEvent;
    //fOnCalcFields: TDataSetNotifyEvent;
    fOnDeleteError: TDataSetErrorEvent;
    fOnEditError: TDataSetErrorEvent;
    fOnNewRecord: TDataSetNotifyEvent;
    fOnPostError: TDataSetErrorEvent;
    method fBindingSource_PositionChanged(sender: Object; e: EventArgs);
    method fDataTable_TableNewRow(sender: Object; e: DataTableNewRowEventArgs);
    //method fDataTable_RowDeleting(sender: Object; e: DataRowChangeEventArgs);
    //method fDataTable_RowDeleted(sender: Object; e: DataRowChangeEventArgs);
    method fDataTable_RowChanging(sender: Object; e: DataRowChangeEventArgs);
    method fDataTable_RowChanged(sender: Object; e: DataRowChangeEventArgs);
    method fDataTable_ColumnChanged(sender: Object; e: DataColumnChangeEventArgs);
    method fDataTable_ColumnChanging(sender: Object; e: DataColumnChangeEventArgs);
    method fBindingSource_AddingNew(sender: Object; e: AddingNewEventArgs);
    method set_Filtered(value: Boolean);
    method set_Filter(value: String);
    class method ValueToString(aField: DataColumn; aValue: Object): String;
  assembly 
    //FActiveDataView: DataView;
//    FBOF: Boolean;
//    FEOF: Boolean;
    FFilter: String;
    FFiltered: Boolean;
    fDataTable: DataTable;
    fBindingSource: System.Windows.Forms.BindingSource;
    method ApplyFilter;
    //method CheckBOF;
    method CheckBrowseMode;
    //method CheckEOF;
    method ColumnsCollectionChanged(Sender: Object; e: CollectionChangeEventArgs);
    //method InsertAt(pos: Int32);
  assembly or protected 
    FState: TCDSState;
    FFields: TCDSFields;
    //FLastInsertID: Int32;
    //FRowsAffected: Int32;
    //InternalRecNo: Int32;
    property Row: DataRow read fBindingSource.Current as DataRow;
    //SavedRow: DataRow;
  protected
    method SetDataTable(value: System.Data.DataTable); virtual;
    procedure DoBeforeOpen; virtual;
    procedure DoAfterOpen; virtual;
    procedure DoBeforeClose; virtual;
    procedure DoAfterClose; virtual;
    //procedure DoBeforeInsert; virtual;
    //procedure DoAfterInsert; virtual;
    //procedure DoBeforeEdit; virtual;
    //procedure DoAfterEdit; virtual;
    procedure DoBeforeCancel; virtual;
    procedure DoAfterCancel; virtual;
    procedure DoBeforePost; virtual;
    procedure DoAfterPost; virtual;
    procedure DoBeforeDelete; virtual;
    procedure DoAfterDelete; virtual;
    procedure DoBeforeScroll; virtual;
    procedure DoAfterScroll; virtual;
    procedure DoBeforeRefresh; virtual;
    procedure DoAfterRefresh; virtual;
    //procedure DoCalcFields; virtual;
    procedure DoDeleteError(E: EDatsetException; var Action: TDataAction); virtual;
    procedure DoEditError(E: EDatsetException; var Action: TDataAction); virtual;
    procedure DoNewRecord; virtual;
    procedure DoPostError(E: EDatsetException; var Action: TDataAction); virtual;
  public 
    constructor;
    constructor(aDataTable: DataTable);

    property DataTable: System.Data.DataTable read fDataTable write SetDataTable;
    
    method Append;
    //method CloneCursor(Source: TCustomClientDataSet);
    
    property Bof: Boolean read fBindingSource.Current = nil;
    method Cancel; virtual;
    method Delete; virtual;
    method Edit; virtual;
    property Eof: Boolean read fBindingSource.Current = nil;
    method FieldByName(FieldName: String): TCDSField;
    property FieldCount: Int32 read FFields.Count;
    method First; virtual;
    method Insert; virtual;
    method Last; virtual;
    method Locate(KeyFields: String; params KeyValues: array of Object): Boolean; virtual;
    method Locate(KeyField: String; KeyValue: Object): Boolean; virtual;
    method Next; virtual;
    method Post; virtual;
    method Prior; virtual;
    method RecNo: Int32;
    method RecordCount: Int32;
    

    { Properties }
    [Browsable(false)]
    property Active: Boolean read write; abstract;
    
    [Browsable(false)]
    property BindingSource: System.Windows.Forms.BindingSource read fBindingSource; implements IBindingListView, 
	ITypedList, ISupportInitializeNotification, ICancelAddNew, System.Windows.Forms.ICurrencyManagerProvider;
    [Browsable(false)]
    property Fields: TCDSFields read FFields;
    [Browsable(false)]
    property Filter: String read FFilter write set_Filter;
    [Browsable(false)]
    property Filtered: Boolean read FFiltered write set_Filtered;
    [Browsable(false)]
    property State: TCDSState read FState;

    property BeforeOpen: TDataSetNotifyEvent read fBeforeOpen write fBeforeOpen;
    property AfterOpen: TDataSetNotifyEvent read fAfterOpen write fAfterOpen;
    property BeforeClose: TDataSetNotifyEvent read fBeforeClose write fBeforeClose;
    property AfterClose: TDataSetNotifyEvent read fAfterClose write fAfterClose;
    //property BeforeInsert: TDataSetNotifyEvent read fBeforeInsert write fBeforeInsert;
    //property AfterInsert: TDataSetNotifyEvent read fAfterInsert write fAfterInsert;
    //property BeforeEdit: TDataSetNotifyEvent read fBeforeEdit write fBeforeEdit;
    //property AfterEdit: TDataSetNotifyEvent read fAfterEdit write fAfterEdit;
    property BeforePost: TDataSetNotifyEvent read fBeforePost write fBeforePost;
    property AfterPost: TDataSetNotifyEvent read fAfterPost write fAfterPost;
    property BeforeCancel: TDataSetNotifyEvent read fBeforeCancel write fBeforeCancel;
    property AfterCancel: TDataSetNotifyEvent read fAfterCancel write fAfterCancel;
    property BeforeDelete: TDataSetNotifyEvent read fBeforeDelete write fBeforeDelete;
    property AfterDelete: TDataSetNotifyEvent read fAfterDelete write fAfterDelete;
    property BeforeScroll: TDataSetNotifyEvent read fBeforeScroll write fBeforeScroll;
    property AfterScroll: TDataSetNotifyEvent read fAfterScroll write fAfterScroll;
    property BeforeRefresh: TDataSetNotifyEvent read fBeforeRefresh write fBeforeRefresh;
    property AfterRefresh: TDataSetNotifyEvent read fAfterRefresh write fAfterRefresh;
    //property OnCalcFields: TDataSetNotifyEvent read fOnCalcFields write fOnCalcFields;
    property OnDeleteError: TDataSetErrorEvent read fOnDeleteError write fOnDeleteError;
    property OnEditError: TDataSetErrorEvent read fOnEditError write fOnEditError;
    property OnNewRecord: TDataSetNotifyEvent read fOnNewRecord write fOnNewRecord;
    property OnPostError: TDataSetErrorEvent read fOnPostError write fOnPostError;
  end;

  TClientDataSet = public abstract class(TCustomClientDataSet)
  private
  public
  end;


implementation

method TCustomClientDataSet.SetDataTable(value: System.Data.DataTable);
begin
  if assigned(fDataTable) then begin
     fDataTable.Columns.CollectionChanged -= new CollectionChangeEventHandler(ColumnsCollectionChanged);
  end;

  fDataTable := value;
  if assigned(fDataTable) then begin
    fDataTable.Columns.CollectionChanged += new CollectionChangeEventHandler(ColumnsCollectionChanged);
    fBindingSource.AddingNew += fBindingSource_AddingNew;
    fBindingSource.PositionChanged += fBindingSource_PositionChanged;
    fBindingSource.DataSource := fDataTable;
    fDataTable.ColumnChanging += fDataTable_ColumnChanging;
    fDataTable.ColumnChanged += fDataTable_ColumnChanged;
    fDataTable.RowChanged += fDataTable_RowChanged;
    fDataTable.RowChanging += fDataTable_RowChanging;
    //fDataTable.RowDeleted += fDataTable_RowDeleted;
    //fDataTable.RowDeleting += fDataTable_RowDeleting;
    ColumnsCollectionChanged(nil, nil);
  end else begin 
    //FActiveDataView := new DataView();
    fBindingSource.DataSource := nil;
  end;
  FState := TCDSState.dsBrowse;
end;

method TCustomClientDataSet.ApplyFilter;
begin
  if FFiltered then
    BindingSource.Filter := Filter
  else
    BindingSource.Filter := '';
end;


(*method TCustomClientDataSet.CheckBOF;
begin
  FBOF := InternalRecNo = -1;
end;*)

method TCustomClientDataSet.CheckBrowseMode;
begin
  if FState not in [TCDSState.dsBrowse, TCDSState.dsInactive] then 
    raise new EDatsetException('Dataset not in browse state');
end;

(*method TCustomClientDataSet.CheckEOF;
begin
  FEOF := (InternalRecNo = -1) or (DV.Count = InternalRecNo);
end;*)

method TCustomClientDataSet.ColumnsCollectionChanged(Sender: Object; e: CollectionChangeEventArgs);
begin
  FFields.Invalidate;
end;

constructor TCustomClientDataSet;
begin
  inherited constructor;
  FFilter := '';
  FFields := new TCDSFields(self);
  FState := TCDSState.dsInactive;
  fBindingSource := new System.Windows.Forms.BindingSource();
  //FLastInsertID := -1;
  //FRowsAffected := -1;
  //FActiveDataView := new DataView();
end;

constructor TCustomClientDataSet(aDataTable: DataTable);
begin
  constructor;
  DataTable := aDataTable;
end;

method TCustomClientDataSet.Append;
begin
  fBindingSource.AddNew;
end;

method TCustomClientDataSet.Cancel;
begin
  fBindingSource.CancelEdit;
end;

method TCustomClientDataSet.Delete;
begin
  CheckBrowseMode();
  fBindingSource.RemoveCurrent;
end;

method TCustomClientDataSet.Edit;
begin
  CheckBrowseMode;
  if fBindingSource.Current = nil then raise new EDatsetException('No current record');
  (fBindingSource.Current as DataRow).BeginEdit;
end;

method TCustomClientDataSet.FieldByName(FieldName: String): TCDSField;
begin
  result := FFields.FieldByName(FieldName);
end;

method TCustomClientDataSet.First;
begin
  fBindingSource.MoveFirst;
end;

method TCustomClientDataSet.Insert;
begin
  fBindingSource.AddNew;
end;

(*method TCustomClientDataSet.CloneCursor(Source: TCustomClientDataSet);
begin
  // Todo: This probably should do a lot more ?
  
  DV.Table := Source.fDataTable;
end;*)

method TCustomClientDataSet.Last;
begin
  fBindingSource.MoveLast;
end;

class method TCustomClientDataSet.ValueToString(aField: DataColumn; aValue: Object): String;
begin
  case &Type.GetTypeCode(aField.DataType) of
    TypeCode.DBNull: Result := 'null';
    TypeCode.Boolean,
    TypeCode.Byte,
    TypeCode.Int16,
    TypeCode.Int32,
    TypeCode.Int64,
    TypeCode.UInt16,
    TypeCode.UInt32,
    TypeCode.UInt64,
    TypeCode.SByte: Result := aValue.ToString;
    TypeCode.Decimal: Result := Decimal(aValue).ToString(System.Globalization.NumberFormatInfo.InvariantInfo);
    TypeCode.Double: result := Double(aValue).ToString(System.Globalization.NumberFormatInfo.InvariantInfo);
    TypeCode.Single: Result := Single(aValue).ToString(System.Globalization.NumberFormatInfo.InvariantInfo);
  else
    result := #39+aValue.ToString.Replace(#39, #39#39)+#39;
  end; // case
end;

method TCustomClientDataSet.Locate(KeyFields: String; params KeyValues: array of Object): Boolean;
var
  lKeyFields: Array of String := KeyFields.Split(';');
  fsb: StringBuilder;
begin
  if lKeyFields.Length <> length(KeyValues) then raise new EDatsetException('KeyFields and KeyValues have a different number of elements');
  fsb := new StringBuilder;
  for i: Integer := 0 to lKeyFields.Length -1 do begin
    var lField := FieldByName(lKeyFields[i]);
    if lField = nil then raise new EDatsetException('Unknown field: '+lKeyFields[i]);
    if i <> 0 then fsb.Append(' AND ');
    fsb.Append('(');
    fsb.Append(lField);
    fsb.Append(' = ');
    fsb.Append(ValueToString(lField.Column, KeyValues[i]));
    fsb.Append(')');
  end;
  var lRows := fDataTable.Select(fsb.ToString);
  if length(lRows) > 0 then begin
     var lIndex := fBindingSource.List.IndexOf(lRows[0]);
     if lIndex <> -1 then begin
       fBindingSource.Position := lIndex;
       exit true;
     end;
  end;
end;

method TCustomClientDataSet.Locate(KeyField: String; KeyValue: Object): Boolean;
begin
  var lField := FieldByName(KeyField);
  if lField = nil then raise new EDatsetException('Unknown field: '+KeyField);
  var lValue: String := ValueToString(lField.Column, KeyValue);
  var lRows := fDataTable.Select(KeyField + ' = '+lValue);
  if length(lRows) > 0 then begin
     var lIndex := fBindingSource.List.IndexOf(lRows[0]);
     if lIndex <> -1 then begin
       fBindingSource.Position := lIndex;
       exit true;
     end;
  end;
end;

method TCustomClientDataSet.Next;
begin
  fBindingSource.MoveNext;
end;

method TCustomClientDataSet.Post;
begin
  fBindingSource.EndEdit;
end;

method TCustomClientDataSet.Prior;
begin
  fBindingSource.MovePrevious;
end;

method TCustomClientDataSet.RecNo: Int32;
begin
  result := fBindingSource.Position;
end;

method TCustomClientDataSet.RecordCount: Int32;
begin
  result := fBindingSource.Count;
end;

method TCustomClientDataSet.set_Filter(value: String);
begin
  if FFilter <> value then begin
    FFilter := value;
    if Filtered then ApplyFilter;
  end;
end;

method TCustomClientDataSet.set_Filtered(value: Boolean);
begin
  if FFiltered <> value then begin
    FFiltered := value;
    ApplyFilter();
  end;
end;

method TCustomClientDataSet.fBindingSource_AddingNew(sender: Object; e: AddingNewEventArgs);
begin
  FState := TCDSState.dsInsert;
end;

method TCustomClientDataSet.fDataTable_ColumnChanging(sender: Object; e: DataColumnChangeEventArgs);
begin
  for i: Integer := 0 to FFields.Count -1 do begin
    if FFields[i].Column = e.Column then begin
      if FFields[i].OnValidate <> nil then FFields[i].OnValidate(FFields[i]);
    end;
  end;
end;

method TCustomClientDataSet.fDataTable_ColumnChanged(sender: Object; e: DataColumnChangeEventArgs);
begin
  for i: Integer := 0 to FFields.Count -1 do begin
    if FFields[i].Column = e.Column then begin
      if FFields[i].OnValidate <> nil then FFields[i].OnChange(FFields[i]);
    end;
  end;
end;

method TCustomClientDataSet.fDataTable_RowChanged(sender: Object; e: DataRowChangeEventArgs);
begin
  case e.Action of
    DataRowAction.Add,
    DataRowAction.Change,
    DataRowAction.ChangeCurrentAndOriginal: BeforePost; 
    DataRowAction.Commit: DoBeforePost;
    DataRowAction.Delete: DoBeforeDelete;
    DataRowAction.Rollback: DoBeforeCancel;
  end; // case
  FState := TCDSState.dsBrowse;
end;

method TCustomClientDataSet.fDataTable_RowChanging(sender: Object; e: DataRowChangeEventArgs);
begin
  case e.Action of
    DataRowAction.Add,
    DataRowAction.Change,
    DataRowAction.ChangeCurrentAndOriginal: BeforePost; 
    DataRowAction.Commit: DoBeforePost;
    DataRowAction.Delete: DoBeforeDelete;
    DataRowAction.Rollback: DoBeforeCancel;
  end; // case
end;

(*method TCustomClientDataSet.fDataTable_RowDeleted(sender: Object; e: DataRowChangeEventArgs);
begin
  DoAfterDelete;
end;

method TCustomClientDataSet.fDataTable_RowDeleting(sender: Object; e: DataRowChangeEventArgs);
begin
  DoBeforeDelete;
end;*)

method TCustomClientDataSet.fDataTable_TableNewRow(sender: Object; e: DataTableNewRowEventArgs);
begin
  //DoAfterInsert;
end;

procedure TCustomClientDataSet.DoBeforeOpen;
begin
  if assigned(fBeforeOpen) then fBeforeOpen(self);
end;

procedure TCustomClientDataSet.DoAfterOpen;
begin
  if assigned(fAfterOpen) then fAfterOpen(self);
end;

procedure TCustomClientDataSet.DoBeforeClose;
begin
  if assigned(fBeforeClose) then fBeforeClose(self);
end;

procedure TCustomClientDataSet.DoAfterClose;
begin
  if assigned(fAfterClose) then fAfterClose(self);
end;

(*procedure TCustomClientDataSet.DoBeforeInsert;
begin
  if assigned(fBeforeInsert) then fBeforeInsert(self);
end;

procedure TCustomClientDataSet.DoAfterInsert;
begin
  if assigned(fAfterInsert) then fAfterInsert(self);
end;

procedure TCustomClientDataSet.DoBeforeEdit;
begin
  if assigned(fBeforeEdit) then fBeforeEdit(self);
end;

procedure TCustomClientDataSet.DoAfterEdit;
begin
  if assigned(fAfterEdit) then fAfterEdit(self);
end;*)

procedure TCustomClientDataSet.DoBeforePost;
begin
  if assigned(fBeforePost) then fBeforePost(self);
end;

procedure TCustomClientDataSet.DoAfterPost;
begin
  if assigned(fAfterPost) then fAfterPost(self);
end;

procedure TCustomClientDataSet.DoBeforeDelete;
begin
  if assigned(fBeforeDelete) then fBeforeDelete(self);
end;

procedure TCustomClientDataSet.DoAfterDelete;
begin
  if assigned(fAfterDelete) then fAfterDelete(self);
end;

procedure TCustomClientDataSet.DoBeforeScroll;
begin
  if assigned(fBeforeScroll) then fBeforeScroll(self);
end;

procedure TCustomClientDataSet.DoAfterScroll;
begin
  if assigned(fAfterScroll) then fAfterScroll(self);
end;

procedure TCustomClientDataSet.DoBeforeRefresh;
begin
  if assigned(fBeforeRefresh) then fBeforeRefresh(self);
end;

procedure TCustomClientDataSet.DoAfterRefresh;
begin
  if assigned(fAfterRefresh) then fAfterRefresh(self);
end;

(*procedure TCustomClientDataSet.DoCalcFields;
begin
  if assigned(fOnCalcFields) then fOnCalcFields(self);
end;*)

procedure TCustomClientDataSet.DoDeleteError(E: EDatsetException; var Action: TDataAction);
begin
  if assigned(fOnDeleteError) then fOnDeleteError.Invoke(self, E, var Action);
end;

procedure TCustomClientDataSet.DoEditError(E: EDatsetException; var Action: TDataAction);
begin
  if assigned(fOnEditError) then fOnDeleteError.Invoke(self, E, var Action);
end;

procedure TCustomClientDataSet.DoNewRecord;
begin
  if assigned(fOnNewRecord) then fOnNewRecord(self);
end;

procedure TCustomClientDataSet.DoPostError(E: EDatsetException; var Action: TDataAction);
begin
  if assigned(fOnPostError) then fOnPostError(self, E, var Action);
end;

method TCustomClientDataSet.fBindingSource_PositionChanged(sender: Object; e: EventArgs);
begin
  if fLastRow = -2 then exit;
  var lLastRow := fLastRow;
  fLastRow := -2;
  try 
    BeforeScroll;
  except
    on ez: EAbort do begin
      fBindingSource.Position := lLastRow;
    end;
  finally
    fLastRow := fBindingSource.Position;
  end;
end;

procedure TCustomClientDataSet.DoBeforeCancel;
begin
  if assigned(fBeforeCancel) then fBeforeCancel(self);
end;

procedure TCustomClientDataSet.DoAfterCancel;
begin
  if assigned(fAfterCancel) then fAfterCancel(self);
end;

method TCDSField.Row: DataRow;
begin
  Result := FDataset.Row;
end;

constructor TCDSField(aDataset: TCustomClientDataSet;aColumn: DataColumn);
begin
  FDataset := aDataset;
  FColumn := aColumn;
end;

method TCDSField.IsNull: Boolean;
begin
  result := Row.IsNull(FColumn);
end;

method TCDSField.set_Value(aValue: Object);
begin
  Row[FColumn] := aValue;
end;

method TCDSField.get_Value: Object;
begin
  Result := Row[FColumn];
end;

method TCDSFields.Invalidate;
begin
  if FItems.Count = FDataSet.fDataTable.Columns.Count then begin
    for i: Integer := 0 to FItems.Count -1 do begin
      FItems[i].IntColumn := FDataSet.fDataTable.Columns[i];
    end;
  end;

  FItems.Clear;
  for i: Integer := 0 to FDataSet.fDataTable.Columns.Count -1 do begin
    FItems.Add(new TCDSField(FDataSet, FDataSet.fDataTable.Columns[i]));
  end;
end;

constructor TCDSFields.Create(aDataset: TCustomClientDataSet);
begin
  FDataSet := aDataset;
  Invalidate;
end;

method TCDSFields.FieldByName(aFieldName: String): TCDSField;
begin
  for i: Integer := 0 to FItems.Count -1 do begin
    if String.Compare(FItems[i].FieldName, aFieldName, StringComparison.InvariantCultureIgnoreCase) = 0 then exit FItems[i];
  end;
end;

end.