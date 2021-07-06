#===============================================================================================================
# 2020 Hay lab, Krembil Centre for Neuroinformatics, Summer School. Code available for educational purposes only
#===============================================================================================================
import scipy
from scipy import stats as st
import numpy

# Connection Probability
connection_prob = {
	'HL23PN1HL23PN1' : 0.50,
	'HL23PN1HL23MN1' : 0.028,
	'HL23PN1HL23BN1' : 0.051,
	'HL23PN1HL23VN1' : 0.051,

	'HL23MN1HL23PN1' : 0.150,
	'HL23MN1HL23MN1' : 0.110,
	'HL23MN1HL23BN1' : 0.120,
	'HL23MN1HL23VN1' : 0.120,

	'HL23BN1HL23PN1' : 0.059,
	'HL23BN1HL23MN1' : 0.055,
	'HL23BN1HL23BN1' : 0.051,
	'HL23BN1HL23VN1' : 0.02,

	'HL23VN1HL23PN1' : 0,
	'HL23VN1HL23MN1' : 0,
	'HL23VN1HL23BN1' : 0.33,
	'HL23VN1HL23VN1' : 0.029}

#Synaptic Conductances
con_PN2PN = 0.00030
con_PN2MN = 0.00030
con_PN2BN = 0.00030
con_PN2VN = 0.00031

con_MN2PN = 0.00066
con_MN2MN = 0.00034
con_MN2BN = 0.00033
con_MN2VN = 0.00046

con_BN2PN = 0.00110
con_BN2MN = 0.00033
con_BN2BN = 0.00033
con_BN2VN = 0.00034

con_VN2PN = 0
con_VN2MN = 0.00036
con_VN2BN = 0.00034
con_VN2VN = 0.00034

#Numbers of synaptic contacts per connection
Ncont_PN2PN = 3
Ncont_PN2MN = 8
Ncont_PN2BN = 8
Ncont_PN2VN = 4

Ncont_MN2PN = 12
Ncont_MN2MN = 12
Ncont_MN2BN = 13
Ncont_MN2VN = 5

Ncont_BN2PN = 17
Ncont_BN2MN = 16
Ncont_BN2BN = 15
Ncont_BN2VN = 7

Ncont_VN2PN = 0
Ncont_VN2MN = 9
Ncont_VN2BN = 11
Ncont_VN2VN = 7


# Rise time
taur_PN2PN = 0.3
taur_PN2MN = 0.3
taur_PN2BN = 0.3
taur_PN2VN = 0.3

taur_MN2PN = 1
taur_MN2MN = 1
taur_MN2BN = 1
taur_MN2VN = 1

taur_BN2PN = 1
taur_BN2MN = 1
taur_BN2BN = 1
taur_BN2VN = 1

taur_VN2PN = 1
taur_VN2MN = 1
taur_VN2BN = 1
taur_VN2VN = 1

# Decay time
taud_PN2PN = 3
taud_PN2MN = 3
taud_PN2BN = 3
taud_PN2VN = 3

taud_MN2PN = 10
taud_MN2MN = 10
taud_MN2BN = 10
taud_MN2VN = 10

taud_BN2PN = 10
taud_BN2MN = 10
taud_BN2BN = 10
taud_BN2VN = 10

taud_VN2PN = 10
taud_VN2MN = 10
taud_VN2BN = 10
taud_VN2VN = 10

# Depression
d_PN2PN = 670
d_PN2MN = 140
d_PN2BN = 510
d_PN2VN = 670

d_MN2PN = 1300
d_MN2MN = 720
d_MN2BN = 710
d_MN2VN = 890

d_BN2PN = 710
d_BN2MN = 700
d_BN2BN = 710
d_BN2VN = 720

d_VN2PN = 300
d_VN2MN = 760
d_VN2BN = 720
d_VN2VN = 720

# Facilitation
f_PN2PN = 17
f_PN2MN = 670
f_PN2BN = 180
f_PN2VN = 17

f_MN2PN = 2
f_MN2MN = 21
f_MN2BN = 21
f_MN2VN = 25

f_BN2PN = 23
f_BN2MN = 21
f_BN2BN = 21
f_BN2VN = 21

f_VN2PN = 160
f_VN2MN = 22
f_VN2BN = 21
f_VN2VN = 21

# Use
use_PN2PN = 0.46
use_PN2MN = 0.09
use_PN2BN = 0.34
use_PN2VN = 0.5

use_MN2PN = 0.3
use_MN2MN = 0.25
use_MN2BN = 0.25
use_MN2VN = 0.31

use_BN2PN = 0.23
use_BN2MN = 0.25
use_BN2BN = 0.25
use_BN2VN = 0.26

use_VN2PN = 0.23
use_VN2MN = 0.27
use_VN2BN = 0.25
use_VN2VN = 0.26

r_NMDA = 2
d_NMDA = 65

#prepost2 is just for test syn, to remove condition where pre==post
syn_params = {

    'none' : {'tau_r_AMPA': taur_PN2PN,
                   'tau_d_AMPA': taud_PN2PN,
                   'tau_r_NMDA': r_NMDA,
                   'tau_d_NMDA': d_NMDA,
                   'e': 0,
                   'Dep': d_PN2PN,
                   'Fac': f_PN2PN,
                   'Use': use_PN2PN,
                   'u0':0,
                   'gmax': 0},

    'HL23PN1HL23PN1' : {'tau_r_AMPA': taur_PN2PN,
                        'tau_d_AMPA': taud_PN2PN,
                        'tau_r_NMDA': r_NMDA,
                        'tau_d_NMDA': d_NMDA,
                        'e': 0,
                        'Dep': d_PN2PN,
                        'Fac': f_PN2PN,
                        'Use': use_PN2PN,
                        'u0':0,
                        'gmax': con_PN2PN},

    'HL23PN1HL23PN2' : {'tau_r_AMPA': taur_PN2PN,
                        'tau_d_AMPA': taud_PN2PN,
                        'tau_r_NMDA': r_NMDA,
                        'tau_d_NMDA': d_NMDA,
                        'e': 0,
                        'Dep': d_PN2PN,
                        'Fac': f_PN2PN,
                        'Use': use_PN2PN,
                        'u0':0,
                        'gmax': con_PN2PN},

    'HL23PN1HL23MN1' : {'tau_r_AMPA': taur_PN2MN,
                        'tau_d_AMPA': taud_PN2MN,
                        'tau_r_NMDA': r_NMDA,
                        'tau_d_NMDA': d_NMDA,
                        'e': 0,
                        'Dep': d_PN2MN,
                        'Fac': f_PN2MN,
                        'Use': use_PN2MN,
                        'u0':0,
                        'gmax': con_PN2MN},

    'HL23PN1HL23BN1' : {'tau_r_AMPA': taur_PN2BN,
                        'tau_d_AMPA': taud_PN2BN,
                        'tau_r_NMDA': r_NMDA,
                        'tau_d_NMDA': d_NMDA,
                        'e': 0,
                        'Dep': d_PN2BN,
                        'Fac': f_PN2BN,
                        'Use': use_PN2BN,
                        'u0':0,
                        'gmax': con_PN2BN},

    'HL23PN1HL23VN1' : {'tau_r_AMPA': taur_PN2VN,
                        'tau_d_AMPA': taud_PN2VN,
                        'tau_r_NMDA': r_NMDA,
                        'tau_d_NMDA': d_NMDA,
                        'e': 0,
                        'Dep': d_PN2VN,
                        'Fac': f_PN2VN,
                        'Use': use_PN2VN,
                        'u0':0,
                        'gmax': con_PN2VN},

    'HL23MN1HL23PN1' : {'tau_r': taur_MN2PN,
                        'tau_d': taud_MN2PN,
                        'Use': use_MN2PN,
                        'Dep': d_MN2PN,
                        'Fac': f_MN2PN,
                        'e': -80,
                        'gmax': con_MN2PN,
                        'u0': 0},
    'HL23MN1HL23MN1' : {'tau_r': taur_MN2MN,
                        'tau_d': taud_MN2MN,
                        'Use': use_MN2MN,
                        'Dep': d_MN2MN,
                        'Fac': f_MN2MN,
                        'e': -80,
                        'gmax': con_MN2MN,
                        'u0': 0},

    'HL23MN1HL23MN2' : {'tau_r': taur_MN2MN,
                        'tau_d': taud_MN2MN,
                        'Use': use_MN2MN,
                        'Dep': d_MN2MN,
                        'Fac': f_MN2MN,
                        'e': -80,
                        'gmax': con_MN2MN,
                        'u0': 0},

    'HL23MN1HL23BN1' : {'tau_r': taur_MN2BN,
                        'tau_d': taud_MN2BN,
                        'Use': use_MN2BN,
                        'Dep': d_MN2BN,
                        'Fac': f_MN2BN,
                        'e': -80,
                        'gmax': con_MN2BN,
                        'u0': 0},
    'HL23MN1HL23VN1' : {'tau_r': taur_MN2VN,
                        'tau_d': taud_MN2VN,
                        'Use': use_MN2VN,
                        'Dep': d_MN2VN,
                        'Fac': f_MN2VN,
                        'e': -80,
                        'gmax': con_MN2VN,
                        'u0': 0},

    'HL23BN1HL23PN1' : {'tau_r': taur_BN2PN,
                        'tau_d': taud_BN2PN,
                        'Use': use_BN2PN,
                        'Dep': d_BN2PN,
                        'Fac': f_BN2PN,
                        'e': -80,
                        'gmax': con_BN2PN,
                        'u0': 0},
    'HL23BN1HL23MN1' : {'tau_r': taur_BN2MN,
                        'tau_d': taud_BN2MN,
                        'Use': use_BN2MN,
                        'Dep': d_BN2MN,
                        'Fac': f_BN2MN,
                        'e': -80,
                        'gmax': con_BN2MN,
                        'u0': 0},

    'HL23BN1HL23BN1' : {'tau_r': taur_BN2BN,
                        'tau_d': taud_BN2BN,
                        'Use': use_BN2BN,
                        'Dep': d_BN2BN,
                        'Fac': f_BN2BN,
                        'e': -80,
                        'gmax': con_BN2BN,
                        'u0': 0},

    'HL23BN1HL23BN2' : {'tau_r': taur_BN2BN,
                        'tau_d': taud_BN2BN,
                        'Use': use_BN2BN,
                        'Dep': d_BN2BN,
                        'Fac': f_BN2BN,
                        'e': -80,
                        'gmax': con_BN2BN,
                        'u0': 0},
    'HL23BN1HL23VN1' : {'tau_r': taur_BN2VN,
                        'tau_d': taud_BN2VN,
                        'Use': use_BN2VN,
                        'Dep': d_BN2VN,
                        'Fac': f_BN2VN,
                        'e': -80,
                        'gmax': con_BN2VN,
                        'u0': 0},

    'HL23VN1HL23PN1' : {'tau_r': taur_VN2PN,
                        'tau_d': taud_VN2PN,
                        'Use': use_VN2PN,
                        'Dep': d_VN2PN,
                        'Fac': f_VN2PN,
                        'e': -80,
                        'gmax': con_VN2PN,
                        'u0': 0},
    'HL23VN1HL23MN1' : {'tau_r': taur_VN2MN,
                        'tau_d': taud_VN2MN,
                        'Use': use_VN2MN,
                        'Dep': d_VN2MN,
                        'Fac': f_VN2MN,
                        'e': -80,
                        'gmax': con_VN2MN,
                        'u0': 0},
    'HL23VN1HL23BN1' : {'tau_r': taur_VN2BN,
                        'tau_d': taud_VN2BN,
                        'Use': use_VN2BN,
                        'Dep': d_VN2BN,
                        'Fac': f_VN2BN,
                        'e': -80,
                        'gmax': con_VN2BN,
                        'u0': 0},
    'HL23VN1HL23VN1' : {'tau_r': taur_VN2VN,
                        'tau_d': taud_VN2VN,
                        'Use': use_VN2VN,
                        'Dep': d_VN2VN,
                        'Fac': f_VN2VN,
                        'e': -80,
                        'gmax': con_VN2VN,
                        'u0': 0},
    'HL23VN1HL23VN2' : {'tau_r': taur_VN2VN,
                        'tau_d': taud_VN2VN,
                        'Use': use_VN2VN,
                        'Dep': d_VN2VN,
                        'Fac': f_VN2VN,
                        'e': -80,
                        'gmax': con_VN2VN,
                        'u0': 0}}

mult_syns = {
    'none' : {'loc':0,'scale':0},
    'HL23PN1HL23PN1' : {'loc':Ncont_PN2PN,'scale':0},
    'HL23PN1HL23PN2' : {'loc':Ncont_PN2PN,'scale':0},
    'HL23PN1HL23MN1' : {'loc':Ncont_PN2MN,'scale':0},
    'HL23PN1HL23BN1' : {'loc':Ncont_PN2BN,'scale':0},
    'HL23PN1HL23VN1' : {'loc':Ncont_PN2VN,'scale':0},

    'HL23MN1HL23PN1' : {'loc':Ncont_MN2PN,'scale':0},
    'HL23MN1HL23MN1' : {'loc':Ncont_MN2MN,'scale':0},
    'HL23MN1HL23MN2' : {'loc':Ncont_MN2MN,'scale':0},
    'HL23MN1HL23BN1' : {'loc':Ncont_MN2BN,'scale':0},
    'HL23MN1HL23VN1' : {'loc':Ncont_MN2VN,'scale':0},

    'HL23BN1HL23PN1' : {'loc':Ncont_BN2PN,'scale':0},
    'HL23BN1HL23MN1' : {'loc':Ncont_BN2MN,'scale':0},
    'HL23BN1HL23BN1' : {'loc':Ncont_BN2BN,'scale':0},
    'HL23BN1HL23BN2' : {'loc':Ncont_BN2BN,'scale':0},
    'HL23BN1HL23VN1' : {'loc':Ncont_BN2VN,'scale':0},

    'HL23VN1HL23PN1' : {'loc':Ncont_VN2PN,'scale':0},
    'HL23VN1HL23MN1' : {'loc':Ncont_VN2MN,'scale':0},
    'HL23VN1HL23BN1' : {'loc':Ncont_VN2BN,'scale':0},
    'HL23VN1HL23VN1' : {'loc':Ncont_VN2VN,'scale':0},
    'HL23VN1HL23VN2' : {'loc':Ncont_VN2VN,'scale':0}}


# synd=.5 ###IN CIRCUIT.PY
# syn_delay = {
#     'none' : {'loc':0, 'scale':0.0},
#     'HL23PN1HL23PN1' : {'loc':synd, 'scale':0.0},
#     'HL23PN1HL23PN2' : {'loc':synd, 'scale':0.0},
#     'HL23PN1HL23MN1' : {'loc':synd, 'scale':0.0},
#     'HL23PN1HL23BN1' : {'loc':1.5, 'scale':0.0},
#     'HL23PN1HL23VN1' : {'loc':1.5, 'scale':0.0},
#
#     'HL23MN1HL23PN1' : {'loc':1.5, 'scale':0.0},
#     'HL23MN1HL23MN1' : {'loc':1.5, 'scale':0.0},
#     'HL23MN1HL23MN2' : {'loc':1.5, 'scale':0.0},
#     'HL23MN1HL23BN1' : {'loc':1.5, 'scale':0.0},
#     'HL23MN1HL23VN1' : {'loc':1.5, 'scale':0.0},
#
#     'HL23BN1HL23PN1' : {'loc':1.5, 'scale':0.0},
#     'HL23BN1HL23MN1' : {'loc':1.5, 'scale':0.0},
#     'HL23BN1HL23BN1' : {'loc':1.5, 'scale':0.0},
#     'HL23BN1HL23BN2' : {'loc':1.5, 'scale':0.0},
#     'HL23BN1HL23VN1' : {'loc':1.5, 'scale':0.0},
#
#     'HL23VN1HL23PN1' : {'loc':1.5, 'scale':0.0},
#     'HL23VN1HL23MN1' : {'loc':1.5, 'scale':0.0},
#     'HL23VN1HL23BN1' : {'loc':1.5, 'scale':0.0},
#     'HL23VN1HL23VN1' : {'loc':1.5, 'scale':0.0}}


both = {'section' : ['apic', 'dend'],
        'fun' : [st.uniform, st.halfnorm],
        'funargs' : [{'loc':0., 'scale':500.},{'loc':-150., 'scale':200.}],
        'funweights' : [1, 1.]}
apic = {'section' : ['apic'],
        'fun' : [st.uniform],
        'funargs' : [{'loc':0., 'scale':500.}],
        'funweights' : [1.]}

dend = {'section' : ['dend'],
        'fun' : [st.uniform],
        'funargs' : [{'loc':0., 'scale':500.}],
        'funweights' : [1.]}

PNdend = {'section' : ['dend'],
        'fun' : [st.halfnorm],
        'funargs' : [{'loc':-150., 'scale':200}],
        'funweights' : [1.]}

pos_args = {
    'none' : dend,
    'HL23PN1HL23PN1' : both,
    'HL23PN1HL23PN2' : both,
    'HL23PN1HL23MN1' : dend,
    'HL23PN1HL23BN1' : dend,
    'HL23PN1HL23VN1' : dend,

    'HL23MN1HL23PN1' : apic,
    'HL23MN1HL23MN1' : dend,
    'HL23MN1HL23MN2' : dend,
    'HL23MN1HL23BN1' : dend,
    'HL23MN1HL23VN1' : dend,

    'HL23BN1HL23PN1' : PNdend,
    'HL23BN1HL23MN1' : dend,
    'HL23BN1HL23BN1' : dend,
    'HL23BN1HL23BN2' : dend,
    'HL23BN1HL23VN1' : dend,

    'HL23VN1HL23PN1' : PNdend,
    'HL23VN1HL23MN1' : dend,
    'HL23VN1HL23BN1' : dend,
    'HL23VN1HL23VN1' : dend,
    'HL23VN1HL23VN2' : dend}
# Template
#     = {
#     'HL23PN1HL23PN1' : ,
#     'HL23PN1HL23MN1' : ,
#     'HL23PN1HL23BN1' : ,
#     'HL23PN1HL23VN1' : ,

#     'HL23MN1HL23PN1' : ,
#     'HL23MN1HL23MN1' : ,
#     'HL23MN1HL23BN1' : ,
#     'HL23MN1HL23VN1' : ,

#     'HL23BN1HL23PN1' : ,
#     'HL23BN1HL23MN1' : ,
#     'HL23BN1HL23BN1' : ,
#     'HL23BN1HL23VN1' : ,

#     'HL23VN1HL23PN1' : ,
#     'HL23VN1HL23MN1' : ,
#     'HL23VN1HL23BN1' : ,
#     'HL23VN1HL23VN1' : }
