unit calculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    result: TLabel;
    btn0: TButton;
    btn00: TButton;
    btndot: TButton;
    Panel12: TPanel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    Panel13: TPanel;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    Panel14: TPanel;
    Btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnequals: TButton;
    btnpercentage: TButton;
    btnbackspace: TButton;
    btnmod: TButton;
    Panel3: TPanel;
    btndivide: TButton;
    btnminus: TButton;
    btnplus: TButton;
    btntimes: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btnplusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnequalsClick(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure Btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure btn00Click(Sender: TObject);
    procedure AdicionarNumero(Digito: String);
    procedure AdicionarSinal(sinal: String);
    procedure btnminusClick(Sender: TObject);
    procedure btntimesClick(Sender: TObject);
    procedure btndivideClick(Sender: TObject);
    procedure btnmodClick(Sender: TObject);
    procedure btnbackspaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var resultado, temp, num1, num2, operador : String;
    var tempresultado : integer;
    var second, resolvido : boolean;


  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure Tform3.AdicionarNumero(Digito: String);
begin
  if resolvido then
  begin
    num1 := Digito;
    result.Caption := Digito;
    resolvido := false;
    resultado := Digito;
    second := false;
  end
  else if not second then
  begin
    num1 := num1 + Digito;
    resultado := resultado + Digito;
    result.Caption := resultado;
  end
  else
  begin
    num2 := num2 + Digito;
    resultado := resultado + Digito;
    result.Caption := resultado;
  end;
end;

procedure TForm3.btn0Click(Sender: TObject);
begin
  AdicionarNumero('0');
end;

procedure TForm3.btn1Click(Sender: TObject);
begin
  AdicionarNumero('1');
end;

procedure TForm3.btn2Click(Sender: TObject);
begin
  AdicionarNumero('2');
end;

procedure TForm3.btn3Click(Sender: TObject);
begin
  AdicionarNumero('3');
end;

procedure TForm3.btn4Click(Sender: TObject);
begin
  AdicionarNumero('4');
end;

procedure TForm3.btn5Click(Sender: TObject);
begin
  AdicionarNumero('5');
end;

procedure TForm3.btn6Click(Sender: TObject);
begin
  AdicionarNumero('6');
end;

procedure TForm3.Btn7Click(Sender: TObject);
begin
  AdicionarNumero('7');
end;

procedure TForm3.btn8Click(Sender: TObject);
begin
  AdicionarNumero('8');
end;

procedure TForm3.btn9Click(Sender: TObject);
begin
  AdicionarNumero('9');
end;


procedure TForm3.btnbackspaceClick(Sender: TObject);
begin
  num1 := '';
  num2 := '';
  result.Caption := '';
  resultado := '';

end;

procedure TForm3.btn00Click(Sender: TObject);
begin
  AdicionarNumero('00');
end;

function modhandler (total, num : integer; expr : string) : integer;
var I, x : integer;
temp : String;
begin
for I := 0 to Length(expr) do begin
  if expr[I] = 'm' then begin
    for x := I + 1 to length(expr) do begin
      if expr[x] in ['0'..'9'] then begin
        temp := temp + expr [x];
      end else if expr [x] in ['+', '-', '*', '/', 'm'] then begin
        Result := num mod strtoint(temp);
      end;

    end;
  end;

end;
end;


function AvaliarExpressao(expr: string): Integer;
var
  i, num, total, temp2: Integer;
  operador: Char;
  temp: string;
begin
  total := 0;
  // começa com '+' pra "adicionar" o primeiro numero
  operador := '+';
  temp := '';

  // roda a conta inteira
  for i := 1 to Length(expr) do
  begin
  // se for um numero, entra no temp, até aparecer um sinal
    if expr[i] in ['0'..'9'] then
      temp := temp + expr[i]
    else if expr[i] in ['+', '-', '*', '/', 'm'] then
  // se for um sinal, ele aplica a equação
  //sim ele n prioriza mult. e div. igual ele deveria, mas isso é problema pra outra hora
    begin
      num := StrToInt(temp);
      case operador of
        'm': total := modhandler(total, num, expr);
        '+': total := total + num;
        '-': total := total - num;
        '*': total := total * num;
        '/': total := total div num;
      end;
  //reseta o temp e muda o operador (ele começa com + pq o mais so coloca o primeiro numero
  //ai ele adiciona o sinal q vai ser usado com o prox. numero q vier
      operador := expr[i];
      temp := '';
    end;
  end;

  // logica pro ultimo numero
  if temp <> '' then
  begin
    num := StrToInt(temp);
    case operador of
      'm': total := modhandler(total, num, expr);
      '+': total := total + num;
      '-': total := total - num;
      '*': total := total * num;
      '/': total := total div num;
    end;
  end;

  Result := total;
end;


procedure TForm3.btnequalsClick(Sender: TObject);
var
  res: Integer;
begin
  try
    res := AvaliarExpressao(resultado);
    result.Caption := IntToStr(res);
    num1 := IntToStr(res);
    num2 := '';
    resolvido := true;
    second := false;
  except
    on E: Exception do
      result.Caption := 'Erro';
  end;
end;


procedure TForm3.btnminusClick(Sender: TObject);
begin
  AdicionarSinal ('-');
end;

procedure TForm3.btnmodClick(Sender: TObject);
begin
  AdicionarSinal ('m')
end;

procedure TForm3.btnplusClick(Sender: TObject);
begin
  AdicionarSinal('+');
end;


procedure TForm3.btntimesClick(Sender: TObject);
begin
  AdicionarSinal('*');
end;

procedure TForm3.btndivideClick(Sender: TObject);
begin
AdicionarSinal('/');
end;

procedure Tform3.AdicionarSinal (sinal : String);
begin

if resolvido then
  begin
    // Continua a partir do resultado anterior
    resultado := num1 + sinal;
    result.Caption := resultado;
    resolvido := false;
    second := true;
    operador := 'soma';
    num2 := '';
  end
  else
  begin
    resultado := resultado + sinal;
    result.Caption := resultado;
    second := true;
    operador := 'soma';
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
    second := False;
end;

end.
