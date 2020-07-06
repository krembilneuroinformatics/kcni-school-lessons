#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;

extern void _CaDynamics_reg(void);
extern void _Ca_HVA_reg(void);
extern void _Ca_LVA_reg(void);
extern void _Gfluct_reg(void);
extern void _Ih_reg(void);
extern void _Im_reg(void);
extern void _K_P_reg(void);
extern void _K_T_reg(void);
extern void _Kv3_1_reg(void);
extern void _NMDA_reg(void);
extern void _NaTg_reg(void);
extern void _Nap_reg(void);
extern void _ProbAMPANMDA_reg(void);
extern void _ProbUDFsyn_reg(void);
extern void _SK_reg(void);
extern void _epsp_reg(void);
extern void _tonic_reg(void);

void modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," CaDynamics.mod");
    fprintf(stderr," Ca_HVA.mod");
    fprintf(stderr," Ca_LVA.mod");
    fprintf(stderr," Gfluct.mod");
    fprintf(stderr," Ih.mod");
    fprintf(stderr," Im.mod");
    fprintf(stderr," K_P.mod");
    fprintf(stderr," K_T.mod");
    fprintf(stderr," Kv3_1.mod");
    fprintf(stderr," NMDA.mod");
    fprintf(stderr," NaTg.mod");
    fprintf(stderr," Nap.mod");
    fprintf(stderr," ProbAMPANMDA.mod");
    fprintf(stderr," ProbUDFsyn.mod");
    fprintf(stderr," SK.mod");
    fprintf(stderr," epsp.mod");
    fprintf(stderr," tonic.mod");
    fprintf(stderr, "\n");
  }
  _CaDynamics_reg();
  _Ca_HVA_reg();
  _Ca_LVA_reg();
  _Gfluct_reg();
  _Ih_reg();
  _Im_reg();
  _K_P_reg();
  _K_T_reg();
  _Kv3_1_reg();
  _NMDA_reg();
  _NaTg_reg();
  _Nap_reg();
  _ProbAMPANMDA_reg();
  _ProbUDFsyn_reg();
  _SK_reg();
  _epsp_reg();
  _tonic_reg();
}
