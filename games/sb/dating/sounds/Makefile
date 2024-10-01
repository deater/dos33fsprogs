ZX02 = ~/research/6502_compression/zx02.git/build/zx02 -f

all:	m_buh.btc.zx02 m_duh.btc.zx02 m_fuh.btc.zx02 \
	h_buh.btc.zx02 h_duh.btc.zx02 h_fuh.btc.zx02 \
	m_sb_on_point.btc.zx02

####

m_buh.btc.zx02:	m_buh.btc
	$(ZX02) m_buh.btc m_buh.btc.zx02

m_duh.btc.zx02:	m_duh.btc
	$(ZX02) m_duh.btc m_duh.btc.zx02

m_fuh.btc.zx02:	m_fuh.btc
	$(ZX02) m_fuh.btc m_fuh.btc.zx02

####

h_buh.btc.zx02:	h_buh.btc
	$(ZX02) h_buh.btc h_buh.btc.zx02

h_duh.btc.zx02:	h_duh.btc
	$(ZX02) h_duh.btc h_duh.btc.zx02

h_fuh.btc.zx02:	h_fuh.btc
	$(ZX02) h_fuh.btc h_fuh.btc.zx02

m_sb_on_point.btc.zx02:	m_sb_on_point.btc
	$(ZX02) m_sb_on_point.btc m_sb_on_point.btc.zx02



clean:	
	rm -f *.zx02
