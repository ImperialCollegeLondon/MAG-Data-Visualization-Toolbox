Info	05/07/24	10:11:48.591	GSEOS	0	1	********************************************************************************
Info	05/07/24	10:11:48.593	GSEOS	0	1	GSEOS 8.1.1497
Info	05/07/24	10:11:48.593	GSEOS	0	1	IMAP
Info	05/07/24	10:11:48.595	GSEOS	0	1	Platform: Windows-10-10.0.22621
Info	05/07/24	10:11:48.595	GSEOS	0	1	Tue May  7 10:11:48 2024
Info	05/07/24	10:11:48.595	GSEOS	0	1	********************************************************************************
Error	05/07/24	10:11:49.487	Net	0	1	Net server error: No valid port configured, server "NET_OASIS_SCE_IN_ANALOG" disabled.
Error	05/07/24	10:11:49.487	Net	0	1	Net server error: No valid port configured, server "NET_OASIS_SCE_IN_STATUS" disabled.
Info	05/07/24	10:11:49.489	Net	0	1	Server connection: pytest_recv_tlm has been started.
Info	05/07/24	10:11:49.489	Net	0	1	Server connection: pytest_send_tc has been started.
Info	05/07/24	10:11:49.490	Net	0	1	Server connection: NET_OASIS_SEND_CMD has been started.
Info	05/07/24	10:11:49.490	Net	0	1	Server connection: NET_OASIS_RECV_INST_TLM has been started.
Info	05/07/24	10:11:49.490	Net	0	1	Server connection: NET_OASIS_CMD_DECODER_STATUS has been started.
Info	05/07/24	10:11:49.490	Net	0	1	Server connection: NET_OASIS_SEND_SCE_CMD has been started.
Info	05/07/24	10:11:49.525	Binary Writer	0	1	Binary Writer: "CCSDS_FRAG_TLM" started.
Info	05/07/24	10:11:50.437	Version	0	1	
Info	05/07/24	10:11:50.437	Version	0	1	Version Control Information
Info	05/07/24	10:11:50.437	Version	0	1	----------------------------------------------------------------------
Info	05/07/24	10:11:50.437	Version	0	1	GSEOS:         8.1.1497
Info	05/07/24	10:11:50.437	Version	0	1	Python:        3.7.7 (default, Jun 19 2020, 21:06:32) [MSC v.1900 64 bit (AMD64)]
Info	05/07/24	10:11:50.437	Version	0	1	ExcelLoad:     4.4.047
Info	05/07/24	10:11:50.437	Version	0	1	IMAP - MAG:
Info	05/07/24	10:11:50.437	Version	0	1	
Info	05/07/24	10:11:50.437	Version	0	1	Spreadsheet Version Information
Info	05/07/24	10:11:50.437	Version	0	1	----------------------------------------------------------------------
Info	05/07/24	10:11:50.437	Version	0	1	IMAP_Common\TLM_SC.xls (Release: 2024-04-17 Rev: 1.0) converted: Mon Apr 22 14:06:13 2024
Info	05/07/24	10:11:50.437	Version	0	1	Instruments\MAG_Common\CMD_MAG.xls (Release: 2023-09-01 Rev: None) converted: Wed Apr 24 10:07:41 2024
Info	05/07/24	10:11:50.437	Version	0	1	Instruments\MAG_Common\TLM_MAG.xls (Release: 2023-09-01 Rev: 1.0) converted: Wed Apr 24 10:07:49 2024
Info	05/07/24	10:11:50.437	Version	0	1	Instruments\MAG_Common\TLM_MAG_SCI.xls (Release: 2023-09-01 Rev: 1.0) converted: Wed Apr 24 10:08:06 2024
Info	05/07/24	10:11:50.437	Version	0	1	Instruments\MAG_Common\TLM_MAG_decoders.xls (Release: 0000-00-00 Rev: 0.0) converted: Wed Apr 24 10:08:16 2024
Info	05/07/24	10:11:50.437	Version	0	1	Instruments\MAG_Common\TLM_MAG_soloScience.xls (Release: 0000-00-00 Rev: 0.0) converted: Wed Apr 24 10:08:23 2024
Info	05/07/24	10:11:50.437	Version	0	1	----------------------------------------------------------------------
Info	05/07/24	10:11:50.437	Version	0	1	
Info	05/07/24	10:11:50.602	IMAP_Bios	0	1	Loading IMAP SCE interface.
Info	05/07/24	10:11:50.602	Message	0	1	Setting Message Filter: Error reading from pipeOut:*, ERROR, OKBios, 0.
Info	05/07/24	10:11:50.813	OKBios	0	1	Initializing device: XEM1
Info	05/07/24	10:11:50.815	OKBios	0	1	Entering device service thread for device: XEM1.
Error	05/07/24	10:11:50.855	OKBios	0	1	Error initializing device: XEM1: No Opal Kelly FrontPanel devices found.
Error	05/07/24	10:11:50.855	IMAP_Bios	0	1	Error importing module OKBios: Error initializing device: XEM1: No Opal Kelly FrontPanel devices found..
Info	05/07/24	10:11:50.855	Message	0	1	Removing Message Filter: Error reading from pipeOut:*, ERROR, OKBios, 0.
Info	05/07/24	10:11:50.865	OKBios	0	1	Device service thread for device: XEM1 terminated.
Warn	05/07/24	10:11:50.950	User	0	1	config: Instrument Sys Path not configured
Info	05/07/24	10:11:50.950	User	0	1	config: Initializing Command Logger
Info	05/07/24	10:11:51.061	User	0	1	config:CommandLogger - Ignoring commands matching regex: 'xxx'
Warn	05/07/24	10:11:51.061	User	0	1	config: Telemetry Monitor not configured
Warn	05/07/24	10:11:51.061	User	0	1	config: Memory Dump Monitor not configured
Warn	05/07/24	10:11:51.061	User	0	1	config: Alarm Monitor not configured
Warn	05/07/24	10:11:51.061	User	0	1	config: UDP Exploder not configured
Info	05/07/24	10:11:51.061	User	0	1	config: Initializing CCSDS Dispatcher
Info	05/07/24	10:11:51.099	User	0	1	config:ccsds_dispatch - APID 0x431 -> MAG_EHS_ERRDATA
Info	05/07/24	10:11:51.099	User	0	1	config:ccsds_dispatch - APID 0x401 -> MAG_EHS_BSW
Info	05/07/24	10:11:51.099	User	0	1	config:ccsds_dispatch - APID 0x425 -> MAG_ELS_ITF
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x40e -> MAG_MEM_MRAMTSEGREP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x433 -> MAG_TCC_FEEFAIL
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x435 -> MAG_TCC_PARAMFAIL
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x436 -> MAG_TCC_FILEFAIL
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x415 -> MAG_HSK_SID20
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3e3 -> MAG_PROG_NOOP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x406 -> MAG_PROG_BTSUCC
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x405 -> MAG_PROG_BTSUCC
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x400 -> MAG_PROG_MTRAN
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x422 -> MAG_TCA_SUCC
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x423 -> MAG_TCC_SUCC
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x404 -> MAG_HSK_SID1
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x41f -> MAG_HSK_SID2
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x427 -> MAG_HSK_PW
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x428 -> MAG_HSK_STATUS
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x41b -> MAG_HSK_PROCSTAT
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x43a -> MAG_HSK_SCI
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x43b -> MAG_HSK_SCI
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x41d -> MAG_HSK_SID15
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x424 -> MAG_HSK_SID12
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x41e -> MAG_HSK_SID16
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3e9 -> MAG_SCI_IALIRT
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3fc -> MAG_SCI_IALIRT
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x40c -> MAG_SCI_1920
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x41c -> MAG_SCI_NORM
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42c -> MAG_SCI_BURST
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x409 -> MAG_MEM_CHCKREP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3fa -> MAG_MEM_DMP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x40d -> MAG_HSK_HKADCPRMLIM
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3e8 -> MAG_HSK_AUTONOMY
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x426 -> MAG_TCA_INVCCSDS
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x429 -> MAG_TCC_FAIL
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42a -> MAG_TCC_FAILMEM
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42b -> MAG_EHS_SWTRAP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42d -> MAG_TCC_SPIERR
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42f -> MAG_EHS_AUTONOMY
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x430 -> MAG_EHS_GENEVNT
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x42e -> MAG_EHS_HKADC
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x402 -> MAG_EHS_SWPCKDROP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x40a -> MAG_EHS_CRSHREP
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x439 -> MAG_ELS_CONFLD
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x438 -> MAG_EHS_FEE
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x437 -> MAG_EHS_BUFF
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x432 -> MAG_EHS_SEMAPH
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x3fe -> MAG_EHS_OSERR
Info	05/07/24	10:11:51.101	User	0	1	config:ccsds_dispatch - APID 0x434 -> MAG_TCC_OSFAIL
Warn	05/07/24	10:11:51.101	User	0	1	config: Telemetry Watchdog not configured
Warn	05/07/24	10:11:51.101	User	0	1	config: Binary Log not configured
Info	05/07/24	10:11:51.101	User	0	1	config: Initializing CSV Exports
Info	05/07/24	10:11:51.137	User	0	1	config:csvlog - export_sidone
Info	05/07/24	10:11:51.137	User	0	1	config:csvlog - export_conf
Info	05/07/24	10:11:51.141	User	0	1	config:csvlog - export_sidtwo
Info	05/07/24	10:11:51.141	User	0	1	config:csvlog - export_data
Info	05/07/24	10:11:51.141	User	0	1	config:csvlog - export_pwr
Info	05/07/24	10:11:51.141	User	0	1	config:csvlog - export_stat
Info	05/07/24	10:11:51.141	User	0	1	config:csvlog - export_proc
Info	05/07/24	10:11:51.142	User	0	1	config:csvlog - export_mem
Info	05/07/24	10:11:51.142	User	0	1	config:csvlog - export_hkadc
Info	05/07/24	10:11:51.142	User	0	1	config:csvlog - export_ialirt
Warn	05/07/24	10:11:51.153	User	0	1	config: Test Core not configured
Warn	05/07/24	10:11:51.153	User	0	1	config: Recorder not configured
Warn	05/07/24	10:11:51.153	User	0	1	config: RS232 BIOS not configured
Info	05/07/24	10:12:01.773	Sequencer	0	1	Sequencer 'SCE_IN_STATUS Simulator' started.
Info	05/07/24	10:12:03.315	Sequencer	0	1	Sequencer 'Check Time & Status Customization File Existence' started.
Info	05/07/24	10:13:22.618	Net	0	1	Client connection: tsim established.
Info	05/07/24	10:13:22.838	Net	0	1	Client connection: tsim has been closed by remote end.
Info	05/07/24	10:14:40.628	Net	0	1	Client connection: tsim established.
Info	05/07/24	10:32:12.928	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_pwr_on_tonormal_lab.prc,v $
Info	05/07/24	10:32:13.598	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_pwr_on_lab.prc,v $
Info	05/07/24	10:32:13.608	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:13.644	CSTOL	0	1	@PW  MAG ready to power on.
Info	05/07/24	10:32:17.006	CSTOL	0	1	@PW  Waiting for BSW boot event...
Info	05/07/24	10:32:17.073	CSTOL	0	1	@PW  Boot packet received. Proceeding to verification.
Info	05/07/24	10:32:17.108	CSTOL	0	1	@PW  Sending NOOP to stay in BSW...
Warn	05/07/24	10:32:17.183	CSTOL	0	1	@PW  Error in boot event.
Warn	05/07/24	10:32:17.194	CSTOL	0	1	@PW  Boot EVENT_ID = aswBootSuccess
Warn	05/07/24	10:32:17.204	CSTOL	0	1	@PW  Boot PUS_STYPE = 5. DN
Warn	05/07/24	10:32:17.217	CSTOL	0	1	@PW  Boot PUS_SSUBTYPE = 1. DN
Warn	05/07/24	10:32:17.227	CSTOL	0	1	@PW  Boot SW_VERNUM = 401. DN
Info	05/07/24	10:32:17.239	CSTOL	0	1	@PW  Investigate error before proceeding.
Info	05/07/24	10:32:17.250	CSTOL	0	1	@PW  Enter GO to continue or
Info	05/07/24	10:32:17.260	CSTOL	0	1	@PW  GOTO FINISH to exit the procedure.
Info	05/07/24	10:32:23.122	CSTOL	0	1	MAG_PROG_BTSUCC PROM_CSUM = 0. DN
Info	05/07/24	10:32:23.134	CSTOL	0	1	@PW  Expected checksum is 35732. DN
Error	05/07/24	10:32:24.181	CSTOL	0	1	@PW  BSW Checksum incorrect. Investigate before proceeding.
Info	05/07/24	10:32:24.194	CSTOL	0	1	@PW  Enter GO to continue or GOTO FINISH to abort.
Info	05/07/24	10:32:26.803	CSTOL	0	1	@PW  User has continued.
Info	05/07/24	10:32:26.836	CSTOL	0	1	MAG_PROG_BTSUCC EVENT_ID = aswBootSuccess
Info	05/07/24	10:32:26.846	CSTOL	0	1	MAG_PROG_BTSUCC SW_VERNUM = 401. DN
Info	05/07/24	10:32:26.858	CSTOL	0	1	MAG_PROG_BTSUCC PROM_CSUM = 0. DN
Info	05/07/24	10:32:26.868	CSTOL	0	1	MAG_PROG_BTSUCC HW_MODEL = DEV
Info	05/07/24	10:32:26.901	CSTOL	0	1	@PW  End of MAG Power On Script.
Info	05/07/24	10:32:26.911	CSTOL	0	1	@PW  Finishing $RCSfile: mag_pwr_on_lab.prc,v $
Info	05/07/24	10:32:27.030	CSTOL	0	1	@PW  Transitioning to ASW in MRAMSLOT1...
Info	05/07/24	10:32:27.642	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_transition.prc,v $
Info	05/07/24	10:32:27.654	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:27.730	CSTOL	0	1	@PW  Waiting 3 seconds to allow user to abort...
Info	05/07/24	10:32:30.831	CSTOL	0	1	@PW  Waiting for boot event packet...
Info	05/07/24	10:32:30.887	CSTOL	0	1	@PW  ASW boot packet received. Proceeding to verification.
Info	05/07/24	10:32:31.042	CSTOL	0	1	MAG_PROG_BTSUCC EVENT_ID = aswBootSuccess
Info	05/07/24	10:32:31.053	CSTOL	0	1	MAG_PROG_BTSUCC PHAPID = 1030. DN
Info	05/07/24	10:32:31.065	CSTOL	0	1	MAG_PROG_BTSUCC SW_VERNUM = 401. DN
Info	05/07/24	10:32:31.075	CSTOL	0	1	MAG_PROG_MTRAN EVENT_ID = modeTransition
Info	05/07/24	10:32:31.086	CSTOL	0	1	MAG_PROG_MTRAN PREVM_ID = Standby
Info	05/07/24	10:32:31.098	CSTOL	0	1	MAG_PROG_MTRAN CURRM_ID = Config
Info	05/07/24	10:32:31.128	CSTOL	0	1	@PW  Successfully transitioned to ASW.
Info	05/07/24	10:32:31.171	CSTOL	0	1	@PW
Info	05/07/24	10:32:31.180	CSTOL	0	1	@PW   Exiting mag_transition.prc
Info	05/07/24	10:32:31.861	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_activate.prc,v $
Info	05/07/24	10:32:31.871	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:31.946	CSTOL	0	1	@PW  Activating FIBFOB with delay, and monitoring...
Info	05/07/24	10:32:34.737	CSTOL	0	1	@PW  User has sent command to activate FIBFOB...
Error	05/07/24	10:32:34.815	CSTOL	0	1	@PW  FIBFOB activation command failed.
Info	05/07/24	10:32:34.826	CSTOL	0	1	@PW  Enter GO to continue or GOTO FINISH to abort.
Info	05/07/24	10:32:44.540	CSTOL	0	1	@PW  User has continued.
Info	05/07/24	10:32:44.668	CSTOL	0	1	@PW  Command to activate FIBFOB is accepted and completed.
Info	05/07/24	10:32:44.711	CSTOL	0	1	@PW
Info	05/07/24	10:32:44.724	CSTOL	0	1	@PW   Exiting mag_activate
Info	05/07/24	10:32:45.352	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_check_hk.prc,v $
Info	05/07/24	10:32:45.365	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:45.496	CSTOL	0	1	@PW  Requesting MAG Power HK packet...
Info	05/07/24	10:32:47.448	CSTOL	0	1	@PW  MAG Power HK Report received. Proceeding to verification.
Info	05/07/24	10:32:49.437	CSTOL	0	1	@PW  Status packet received. Proceeding to verification.
Info	05/07/24	10:32:49.721	CSTOL	0	1	MAG_HSK_PW P1V5V = 1.445796 V
Info	05/07/24	10:32:49.733	CSTOL	0	1	MAG_HSK_PW P1V8V = 1.847406 V
Info	05/07/24	10:32:49.744	CSTOL	0	1	MAG_HSK_PW P2V5V = 2.489982 V
Info	05/07/24	10:32:49.756	CSTOL	0	1	MAG_HSK_PW P3V3V = 3.2592784 V
Info	05/07/24	10:32:49.766	CSTOL	0	1	MAG_HSK_PW P8V = 8.7595594 V
Info	05/07/24	10:32:49.778	CSTOL	0	1	MAG_HSK_PW N8V = -9.0686428 V
Info	05/07/24	10:32:49.789	CSTOL	0	1	MAG_HSK_PW P2V4V = 3.0264728 V
Info	05/07/24	10:32:49.802	CSTOL	0	1	MAG_HSK_PW P1V5I = 415.8761619 mA
Info	05/07/24	10:32:49.815	CSTOL	0	1	MAG_HSK_PW P1V8I = 25.91376245 mA
Info	05/07/24	10:32:49.825	CSTOL	0	1	MAG_HSK_PW P2V5I = 93.00208975 mA
Info	05/07/24	10:32:49.838	CSTOL	0	1	MAG_HSK_PW P3V3I = 117.759283 mA
Info	05/07/24	10:32:49.849	CSTOL	0	1	MAG_HSK_PW P8VI = 175.3445 mA
Info	05/07/24	10:32:49.861	CSTOL	0	1	MAG_HSK_PW N8VI = 127.0794 mA
Info	05/07/24	10:32:49.871	CSTOL	0	1	MAG_HSK_PW ICU_TEMP = 23.42448 C
Info	05/07/24	10:32:49.884	CSTOL	0	1	MAG_HSK_PW FOB_TEMP = 20.10183707 C
Info	05/07/24	10:32:49.894	CSTOL	0	1	MAG_HSK_PW FIB_TEMP = 28.51419774 C
Info	05/07/24	10:32:49.905	CSTOL	0	1	MAG_HSK_STATUS MAGMODE = Config
Info	05/07/24	10:32:49.947	CSTOL	0	1	@PW  MAG Power HK parameters within limits. Not in SAFE.
Info	05/07/24	10:32:49.990	CSTOL	0	1	@PW
Info	05/07/24	10:32:50.000	CSTOL	0	1	@PW   Exiting mag_check_hk.prc
Info	05/07/24	10:32:50.165	CSTOL	0	1	MAG_HSK_PW MAGOSATFLAGX = NotSaturated
Info	05/07/24	10:32:50.177	CSTOL	0	1	MAG_HSK_PW MAGOSATFLAGY = NotSaturated
Info	05/07/24	10:32:50.188	CSTOL	0	1	MAG_HSK_PW MAGOSATFLAGZ = NotSaturated
Info	05/07/24	10:32:50.198	CSTOL	0	1	MAG_HSK_PW MAGISATFLAGX = NotSaturated
Info	05/07/24	10:32:50.210	CSTOL	0	1	MAG_HSK_PW MAGISATFLAGY = NotSaturated
Info	05/07/24	10:32:50.221	CSTOL	0	1	MAG_HSK_PW MAGISATFLAGZ = NotSaturated
Info	05/07/24	10:32:50.233	CSTOL	0	1	MAG_HSK_STATUS FOBSTAT = Active
Info	05/07/24	10:32:50.244	CSTOL	0	1	MAG_HSK_STATUS FIBSTAT = Active
Info	05/07/24	10:32:50.256	CSTOL	0	1	MAG_HSK_PW P8VI = 175.3445 mA
Info	05/07/24	10:32:50.267	CSTOL	0	1	MAG_HSK_PW N8VI = 127.0794 mA
Info	05/07/24	10:32:50.301	CSTOL	0	1	@PW  MAG HK nominal post sensor activation.
Info	05/07/24	10:32:50.391	CSTOL	0	1	@PW  Sending command to go to Normal 2-2 mode...
Info	05/07/24	10:32:51.092	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_science.prc,v $
Info	05/07/24	10:32:51.105	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:52.454	CSTOL	0	1	@PW Normal Mode transition event received. Proceeding to verification.
Info	05/07/24	10:32:52.500	CSTOL	0	1	MAG_PROG_MTRAN EVENT_ID = modeTransition
Info	05/07/24	10:32:52.510	CSTOL	0	1	MAG_PROG_MTRAN PREVM_ID = Config
Info	05/07/24	10:32:52.523	CSTOL	0	1	MAG_PROG_MTRAN CURRM_ID = Normal
Info	05/07/24	10:32:52.555	CSTOL	0	1	@PW  MAG successfully changed mode to Normal
Info	05/07/24	10:32:52.598	CSTOL	0	1	@PW
Info	05/07/24	10:32:52.608	CSTOL	0	1	@PW   Exiting mag_science.prc
Info	05/07/24	10:32:53.322	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_config_FEE.prc,v $
Info	05/07/24	10:32:53.332	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:32:53.400	CSTOL	0	1	@PW  Configuring FOB...
Info	05/07/24	10:32:53.413	CSTOL	0	1	@PW  Setting FOB delay value to 3...
Info	05/07/24	10:32:55.448	CSTOL	0	1	@PW FOB set delay command completed.
Info	05/07/24	10:32:55.493	CSTOL	0	1	@PW  Enabling FEE autorange for FOB with 50 second delay...
Info	05/07/24	10:32:57.450	CSTOL	0	1	@PW  Enable FOB FEE autorange command completed.
Info	05/07/24	10:32:57.484	CSTOL	0	1	@PW  Enabling ICU autorange for FOB with delay count 38400...
Info	05/07/24	10:32:59.450	CSTOL	0	1	@PW  Enable FOB ICU autorange command completed.
Info	05/07/24	10:32:59.490	CSTOL	0	1	@PW
Info	05/07/24	10:32:59.502	CSTOL	0	1	@PW   Exiting mag_config_fee.prc
Info	05/07/24	10:33:00.141	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_config_FEE.prc,v $
Info	05/07/24	10:33:00.151	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:33:00.227	CSTOL	0	1	@PW  Configuring FIB...
Info	05/07/24	10:33:00.239	CSTOL	0	1	@PW  Setting FIB delay value to 3...
Info	05/07/24	10:33:01.483	CSTOL	0	1	@PW FIB set delay command completed.
Info	05/07/24	10:33:01.529	CSTOL	0	1	@PW  Enabling FEE autorange for FIB with 50 second delay...
Info	05/07/24	10:33:03.450	CSTOL	0	1	@PW  Enable FIB FEE autorange command completed.
Info	05/07/24	10:33:03.483	CSTOL	0	1	@PW  Enabling ICU autorange for FIB with delay count 38400...
Info	05/07/24	10:33:05.450	CSTOL	0	1	@PW  Enable FIB ICU autorange command completed.
Info	05/07/24	10:33:05.493	CSTOL	0	1	@PW
Info	05/07/24	10:33:05.503	CSTOL	0	1	@PW   Exiting mag_config_fee.prc
Info	05/07/24	10:33:06.181	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_check_hk.prc,v $
Info	05/07/24	10:33:06.194	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:33:06.315	CSTOL	0	1	@PW  Requesting MAG Power HK packet...
Info	05/07/24	10:33:07.461	CSTOL	0	1	@PW  MAG Power HK Report received. Proceeding to verification.
Info	05/07/24	10:33:09.483	CSTOL	0	1	@PW  Status packet received. Proceeding to verification.
Info	05/07/24	10:33:09.769	CSTOL	0	1	MAG_HSK_PW P1V5V = 1.445796 V
Info	05/07/24	10:33:09.780	CSTOL	0	1	MAG_HSK_PW P1V8V = 1.847406 V
Info	05/07/24	10:33:09.792	CSTOL	0	1	MAG_HSK_PW P2V5V = 2.489982 V
Info	05/07/24	10:33:09.803	CSTOL	0	1	MAG_HSK_PW P3V3V = 3.2592784 V
Info	05/07/24	10:33:09.815	CSTOL	0	1	MAG_HSK_PW P8V = 8.7595594 V
Info	05/07/24	10:33:09.825	CSTOL	0	1	MAG_HSK_PW N8V = -9.0686428 V
Info	05/07/24	10:33:09.838	CSTOL	0	1	MAG_HSK_PW P2V4V = 3.0264728 V
Info	05/07/24	10:33:09.848	CSTOL	0	1	MAG_HSK_PW P1V5I = 415.8761619 mA
Info	05/07/24	10:33:09.859	CSTOL	0	1	MAG_HSK_PW P1V8I = 25.91376245 mA
Info	05/07/24	10:33:09.871	CSTOL	0	1	MAG_HSK_PW P2V5I = 93.00208975 mA
Info	05/07/24	10:33:09.881	CSTOL	0	1	MAG_HSK_PW P3V3I = 117.759283 mA
Info	05/07/24	10:33:09.891	CSTOL	0	1	MAG_HSK_PW P8VI = 175.3445 mA
Info	05/07/24	10:33:09.905	CSTOL	0	1	MAG_HSK_PW N8VI = 127.0794 mA
Info	05/07/24	10:33:09.917	CSTOL	0	1	MAG_HSK_PW ICU_TEMP = 23.42448 C
Info	05/07/24	10:33:09.927	CSTOL	0	1	MAG_HSK_PW FOB_TEMP = 20.10183707 C
Info	05/07/24	10:33:09.940	CSTOL	0	1	MAG_HSK_PW FIB_TEMP = 28.51419774 C
Info	05/07/24	10:33:09.950	CSTOL	0	1	MAG_HSK_STATUS MAGMODE = Normal
Info	05/07/24	10:33:09.994	CSTOL	0	1	@PW  MAG Power HK parameters within limits. Not in SAFE.
Info	05/07/24	10:33:10.036	CSTOL	0	1	@PW
Info	05/07/24	10:33:10.046	CSTOL	0	1	@PW   Exiting mag_check_hk.prc
Info	05/07/24	10:33:10.727	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_verif_science.prc,v $
Info	05/07/24	10:33:10.739	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:33:10.759	CSTOL	0	1	@PW  Verifying FEE configuration...
Info	05/07/24	10:33:12.476	CSTOL	0	1	@PW  Power packet received. Proceeding to verification.
Info	05/07/24	10:33:14.479	CSTOL	0	1	@PW  Status packet received. Proceeding to verification.
Info	05/07/24	10:33:16.658	CSTOL	0	1	@PW  SID15 packet received. Proceeding to verification.
Info	05/07/24	10:33:16.828	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE0
Info	05/07/24	10:33:16.857	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE0
Info	05/07/24	10:33:16.868	CSTOL	0	1	MAG_HSK_STATUS FOBSTAT = Active
Info	05/07/24	10:33:16.880	CSTOL	0	1	MAG_HSK_STATUS FIBSTAT = Active
Info	05/07/24	10:33:16.892	CSTOL	0	1	MAG_HSK_STATUS FOBAR = Enabled
Info	05/07/24	10:33:16.905	CSTOL	0	1	MAG_HSK_STATUS FIBAR = Enabled
Info	05/07/24	10:33:16.917	CSTOL	0	1	MAG_HSK_STATUS ICUFOBAR = Enabled
Info	05/07/24	10:33:16.928	CSTOL	0	1	MAG_HSK_STATUS ICUFIBAR = Enabled
Info	05/07/24	10:33:16.940	CSTOL	0	1	@PW  Number of failed tries for FEE activation:
Info	05/07/24	10:33:16.950	CSTOL	0	1	MAG_HSK_SID15 ISV_FOB_ACTTRIES = 2. DN
Info	05/07/24	10:33:16.963	CSTOL	0	1	MAG_HSK_SID15 ISV_FIB_ACTTRIES = 4. DN
Info	05/07/24	10:33:16.996	CSTOL	0	1	@PW  FEEs are active and in a safe configuration. Proceeding to science verification.
Info	05/07/24	10:33:18.486	CSTOL	0	1	@PW  Science snapshot HK packet received. Proceeding to verification.
Info	05/07/24	10:33:18.618	CSTOL	0	1	MAG_HSK_SCI NPRI_OUTRATE = HZ_2
Info	05/07/24	10:33:18.634	CSTOL	0	1	MAG_HSK_SCI NSEC_OUTRATE = HZ_2
Info	05/07/24	10:33:18.647	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_OBSN = HZ_2
Info	05/07/24	10:33:18.658	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_IBSN = HZ_2
Info	05/07/24	10:33:18.671	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_OBSB = HZ_64
Info	05/07/24	10:33:18.680	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_IBSB = HZ_8
Info	05/07/24	10:33:18.703	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE0
Info	05/07/24	10:33:18.713	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE0
Info	05/07/24	10:33:18.750	CSTOL	0	1	@PW  MAG generating science and FEEs correctly configured.
Info	05/07/24	10:33:18.792	CSTOL	0	1	@PW
Info	05/07/24	10:33:18.805	CSTOL	0	1	@PW   Exiting mag_verif_science.prc
Info	05/07/24	10:33:18.858	CSTOL	0	1	@PW
Info	05/07/24	10:33:18.869	CSTOL	0	1	@PW   Exiting mag_pwr_on_tonormal_lab
Info	05/07/24	10:33:49.795	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_science.prc,v $
Info	05/07/24	10:33:49.805	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:33:51.571	CSTOL	0	1	@PW Burst Mode transition event received. Proceeding to verification.
Info	05/07/24	10:33:51.615	CSTOL	0	1	MAG_PROG_MTRAN EVENT_ID = modeTransition
Info	05/07/24	10:33:51.630	CSTOL	0	1	MAG_PROG_MTRAN PREVM_ID = Normal
Info	05/07/24	10:33:51.641	CSTOL	0	1	MAG_PROG_MTRAN CURRM_ID = Burst
Info	05/07/24	10:33:51.674	CSTOL	0	1	@PW  MAG successfully changed mode to Burst
Info	05/07/24	10:33:51.717	CSTOL	0	1	@PW
Info	05/07/24	10:33:51.727	CSTOL	0	1	@PW   Exiting mag_science.prc
Info	05/07/24	10:34:22.617	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_change_range.prc,v $
Info	05/07/24	10:34:22.628	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:34:22.704	CSTOL	0	1	@PW  Disabling ICU autorange for FIB...
Info	05/07/24	10:34:24.555	CSTOL	0	1	@PW  Disable FIB ICU autorange command completed.
Info	05/07/24	10:34:24.642	CSTOL	0	1	@PW  Disabling FEE autorange for FIB...
Info	05/07/24	10:34:26.549	CSTOL	0	1	@PW  Disable FIB FEE autorange command completed.
Info	05/07/24	10:34:26.592	CSTOL	0	1	@PW  Commanding FIB MAG into RANGE2
Info	05/07/24	10:34:26.602	CSTOL	0	1	@PW  with all Gains set to 3...
Info	05/07/24	10:34:28.562	CSTOL	0	1	@PW  Command FIB into RANGE2 completed.
Info	05/07/24	10:34:28.648	CSTOL	0	1	@PW  Re-enabling FEE autorange for FIB with AR delay S50...
Info	05/07/24	10:34:30.555	CSTOL	0	1	@PW  Re-enable FIB FEE autorange command completed.
Info	05/07/24	10:34:37.572	CSTOL	0	1	@PW  Power packet received. Proceeding to verification.
Info	05/07/24	10:34:39.729	CSTOL	0	1	@PW  SID15 packet received. Proceeding to verification.
Info	05/07/24	10:34:39.750	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINX = 3. DN
Info	05/07/24	10:34:39.760	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINY = 3. DN
Info	05/07/24	10:34:39.772	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINZ = 3. DN
Info	05/07/24	10:34:39.782	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINX = 3. DN
Info	05/07/24	10:34:39.793	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINY = 3. DN
Info	05/07/24	10:34:39.803	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINZ = 3. DN
Info	05/07/24	10:34:39.815	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINX = 3. DN
Info	05/07/24	10:34:39.826	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINY = 3. DN
Info	05/07/24	10:34:39.838	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINZ = 3. DN
Info	05/07/24	10:34:39.849	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINX = 3. DN
Info	05/07/24	10:34:39.861	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINY = 3. DN
Info	05/07/24	10:34:39.875	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINZ = 3. DN
Info	05/07/24	10:34:39.994	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE3
Info	05/07/24	10:34:40.006	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE2
Info	05/07/24	10:34:40.046	CSTOL	0	1	@PW  Range change completed successfully.
Info	05/07/24	10:34:40.099	CSTOL	0	1	@PW
Info	05/07/24	10:34:40.111	CSTOL	0	1	@PW   Exiting mag_change_range
Info	05/07/24	10:34:40.802	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_verif_science.prc,v $
Info	05/07/24	10:34:40.812	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:34:40.834	CSTOL	0	1	@PW  Verifying FEE configuration...
Info	05/07/24	10:34:42.575	CSTOL	0	1	@PW  Power packet received. Proceeding to verification.
Info	05/07/24	10:34:44.594	CSTOL	0	1	@PW  Status packet received. Proceeding to verification.
Info	05/07/24	10:34:46.730	CSTOL	0	1	@PW  SID15 packet received. Proceeding to verification.
Info	05/07/24	10:34:46.904	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE3
Info	05/07/24	10:34:46.915	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE2
Info	05/07/24	10:34:46.927	CSTOL	0	1	MAG_HSK_STATUS FOBSTAT = Active
Info	05/07/24	10:34:46.938	CSTOL	0	1	MAG_HSK_STATUS FIBSTAT = Active
Info	05/07/24	10:34:46.948	CSTOL	0	1	MAG_HSK_STATUS FOBAR = Enabled
Info	05/07/24	10:34:46.960	CSTOL	0	1	MAG_HSK_STATUS FIBAR = Enabled
Info	05/07/24	10:34:46.970	CSTOL	0	1	MAG_HSK_STATUS ICUFOBAR = Enabled
Info	05/07/24	10:34:46.986	CSTOL	0	1	MAG_HSK_STATUS ICUFIBAR = Disabled
Info	05/07/24	10:34:46.996	CSTOL	0	1	@PW  Number of failed tries for FEE activation:
Info	05/07/24	10:34:47.007	CSTOL	0	1	MAG_HSK_SID15 ISV_FOB_ACTTRIES = 0. DN
Info	05/07/24	10:34:47.019	CSTOL	0	1	MAG_HSK_SID15 ISV_FIB_ACTTRIES = 0. DN
Info	05/07/24	10:34:47.052	CSTOL	0	1	@PW  FEEs are active and in a safe configuration. Proceeding to science verification.
Info	05/07/24	10:34:48.595	CSTOL	0	1	@PW  Science snapshot HK packet received. Proceeding to verification.
Info	05/07/24	10:34:48.724	CSTOL	0	1	MAG_HSK_SCI NPRI_OUTRATE = HZ_2
Info	05/07/24	10:34:48.736	CSTOL	0	1	MAG_HSK_SCI NSEC_OUTRATE = HZ_2
Info	05/07/24	10:34:48.746	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_OBSN = HZ_2
Info	05/07/24	10:34:48.756	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_IBSN = HZ_2
Info	05/07/24	10:34:48.767	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_OBSB = HZ_64
Info	05/07/24	10:34:48.779	CSTOL	0	1	MAG_HSK_SID15 ICV_OUTRATE_IBSB = HZ_8
Info	05/07/24	10:34:48.801	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE3
Info	05/07/24	10:34:48.812	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE2
Info	05/07/24	10:34:48.844	CSTOL	0	1	@PW  MAG generating science and FEEs correctly configured.
Info	05/07/24	10:34:48.885	CSTOL	0	1	@PW
Info	05/07/24	10:34:48.898	CSTOL	0	1	@PW   Exiting mag_verif_science.prc
Info	05/07/24	10:35:19.762	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_change_range.prc,v $
Info	05/07/24	10:35:19.773	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:35:19.848	CSTOL	0	1	@PW  Disabling ICU autorange for FOB...
Info	05/07/24	10:35:21.582	CSTOL	0	1	@PW  Disable FOB ICU autorange command completed.
Info	05/07/24	10:35:21.670	CSTOL	0	1	@PW  Disabling FEE autorange for FOB...
Info	05/07/24	10:35:23.589	CSTOL	0	1	@PW  Disable FOB FEE autorange command completed.
Info	05/07/24	10:35:23.634	CSTOL	0	1	@PW  Commanding FOB MAG into RANGE2
Info	05/07/24	10:35:23.647	CSTOL	0	1	@PW  with all Gains set to 3...
Info	05/07/24	10:35:25.582	CSTOL	0	1	@PW  Command FOB into RANGE2 completed.
Info	05/07/24	10:35:25.670	CSTOL	0	1	@PW  Re-enabling FEE autorange for FOB with AR delay S50...
Info	05/07/24	10:35:27.591	CSTOL	0	1	@PW  Re-enable FOB FEE autorange command completed.
Info	05/07/24	10:35:29.592	CSTOL	0	1	@PW  Power packet received. Proceeding to verification.
Info	05/07/24	10:35:31.749	CSTOL	0	1	@PW  SID15 packet received. Proceeding to verification.
Info	05/07/24	10:35:31.769	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINX = 3. DN
Info	05/07/24	10:35:31.782	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINY = 3. DN
Info	05/07/24	10:35:31.792	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG0GAINZ = 3. DN
Info	05/07/24	10:35:31.803	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINX = 3. DN
Info	05/07/24	10:35:31.815	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINY = 3. DN
Info	05/07/24	10:35:31.825	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG1GAINZ = 3. DN
Info	05/07/24	10:35:31.838	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINX = 3. DN
Info	05/07/24	10:35:31.849	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINY = 3. DN
Info	05/07/24	10:35:31.861	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG2GAINZ = 3. DN
Info	05/07/24	10:35:31.874	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINX = 3. DN
Info	05/07/24	10:35:31.885	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINY = 3. DN
Info	05/07/24	10:35:31.895	CSTOL	0	1	MAG_HSK_SID15 ICV_FIB_RG3GAINZ = 3. DN
Info	05/07/24	10:35:32.007	CSTOL	0	1	MAG_HSK_PW MAGORANGE = RANGE2
Info	05/07/24	10:35:32.019	CSTOL	0	1	MAG_HSK_PW MAGIRANGE = RANGE2
Info	05/07/24	10:35:32.052	CSTOL	0	1	@PW  Range change completed successfully.
Info	05/07/24	10:35:32.107	CSTOL	0	1	@PW
Info	05/07/24	10:35:32.118	CSTOL	0	1	@PW   Exiting mag_change_range
Info	05/07/24	10:35:32.865	CSTOL	0	1	@PW  Starting procedure $RCSfile: mag_science.prc,v $
Info	05/07/24	10:35:32.877	CSTOL	0	1	@PW  $Revision: 1.0 $
Info	05/07/24	10:35:40.653	CSTOL	0	1	@PW Burst Mode transition event received. Proceeding to verification.
Info	05/07/24	10:35:40.696	CSTOL	0	1	MAG_PROG_MTRAN EVENT_ID = modeTransition
Info	05/07/24	10:35:40.707	CSTOL	0	1	MAG_PROG_MTRAN PREVM_ID = Config
Info	05/07/24	10:35:40.719	CSTOL	0	1	MAG_PROG_MTRAN CURRM_ID = Burst
Info	05/07/24	10:35:40.752	CSTOL	0	1	@PW  MAG successfully changed mode to Burst
Info	05/07/24	10:35:40.796	CSTOL	0	1	@PW
Info	05/07/24	10:35:40.805	CSTOL	0	1	@PW   Exiting mag_science.prc
