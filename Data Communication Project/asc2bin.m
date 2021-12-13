function dn = asc2bin(txt)
dec=double(txt); % Text to ASCII (decimal)
p2=2.^(0:-1:-7);
B=mod(floor(p2'*dec),2); % Decimal to binary conversion
dn=reshape(B,1,numel(B)); % Bytes to serial conversion
end
