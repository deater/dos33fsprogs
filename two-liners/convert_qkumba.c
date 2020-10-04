i = 0;
e = 0;

do
{
enc[e++] = ((in[i + 2] & 3) << 4) + ((in[i + 1] & 3) << 2) + (in[i + 0] & 3) + 32;
in[i + 0] = (in[i + 0] >> 2) + 32;
in[i + 1] = (in[i + 1] >> 2) + 32;
in[i + 2] = (in[i + 2] >> 2) + 32;
write(o, in + i, 3);
}
while ((i += 3) < filesize);
write(o, enc, sizeof(enc));

