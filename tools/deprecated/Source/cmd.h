



void sendConfig (char cmd1, char cmd2);
void sendReset (void);
void sendClearSettings (void);
void sendLogo (void);
void sendRawRGB (char *fileName);
void sendPPM (char *fileName);
void sendFSQ (char *fileName);
void sendPalBinary (char *fileName);
void sendPalText (char *fileName);
void sendPalAlt (char *fileName);
void sendSmartDMD (char *fileName);
void sendDisplayTimings (int T0, int T1, int T2, int T3, int T4);
void uploadFile (char *fileName);