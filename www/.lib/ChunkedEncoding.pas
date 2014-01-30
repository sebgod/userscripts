unit ChunkedEncoding;

procedure PrintChunk(const str : String);
begin
    PrintLn(Length(str));
    PrintLn(str);
end;