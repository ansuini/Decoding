import os
from os.path import join
import numpy as np
from matplotlib import pyplot as plt
from scipy.io import loadmat
from scipy.stats import pearsonr
from tqdm import tqdm
import h5py

n_stim = 1440
ROOT = join('/home','ansuini','repos','Decoding')


# Experiment types
Experiments = ['Controls', 'Experimentals', 'Naive']
TypeUnits = ['su','mua','all']

# Areas for each experiment
Areas = {}
Areas['Controls']     = ['v1','ll']
Areas['Experimentals'] = ['v1','ll']
Areas['Naive']        = ['v1','lm','li','ll']

TargetAreas = ['v1','ll']

# Color codes for each experiment
Colors = {}
Colors['Controls'] = 'b'
Colors['Experimentals'] = 'r'
Colors['Naive'] = 'g'


def loadStimFeatures():
    '''
    Load matrix with information on stimuli features
    '''
    M = loadmat(join(ROOT, 'data', 'stimFeatures.mat'))
    return M['X']


def parseContinuousStimFeatures():
    '''
    Parse stimulus continuous features matrix
    '''
    M = loadStimFeatures()
    
    #print(M.shape)
    
    tags = ['area','eccentricity','orientation',
            'luminosity','posx','posy']
    
    # continuum
    area           = M[:,1]
    eccentricity   = M[:,10]
    orientation    = M[:,11]
    luminosity     = M[:,17]
    posx           = M[:,2]
    posy           = M[:,3]
   
    
    values = [area,eccentricity,orientation,luminosity,posx,posy]        
    return dict(zip(tags,values))


def parseDiscreteStimFeatures():
    '''
    Parse stimulus discrete features matrix (object id)
    '''
    M = loadStimFeatures()

    tags = ['objid']
        
    # categorical
    objid          = M[:,20]
    
    values = [objid]        
    return dict(zip(tags,values))



def printUnitsResume():
    '''
    Prints number of units for each experiment area and unit type 
    '''
    target_areas = ['v1','ll']
    for exp in Experiments:
        filename = join(ROOT, 'data', 'Polished', exp, 'neuronDB.h5')
        f = h5py.File(filename, 'r')

        nunits_su  = []
        nunits_mua = []
        nunits_all = []

        for area in target_areas: 

            x1 = f['/' + area + '/mua/data/count'][:, 0:1440]
            nunits_mua.append(x1.shape[0])    

            x2 = f['/' + area + '/su/data/count'][:, 0:1440]        
            nunits_su.append(x2.shape[0]) 
            
            x = np.vstack((x1, x2))
            nunits_all.append(x.shape[0]) 

        print(exp)
        print('SU  : ', nunits_su)
        print('MUA : ', nunits_mua)
        print('ALL : ', nunits_all)
        print('')

def loadFiringRates(exp,area,typeunit):
    '''
    Load firing rates matrix of a specific combination of 
    experiment (Control, Experimental, Naive), area (v1, ll)
    and type of unit (mua,su,all).
    
    Returns a matrix of the form (n.of stimuli, n.of neurons)
    '''
    filename = join(ROOT, 'data', 'Polished', exp, 'neuronDB.h5')
    f = h5py.File(filename, 'r')
    
    if typeunit == 'mua':
        x = f['/' + area + '/mua/data/count'][:, 0:1440]
    
    if typeunit == 'su':
        x = f['/' + area + '/su/data/count'][:, 0:1440]
        
    if typeunit == 'all':
        x1 = f['/' + area + '/mua/data/count'][:, 0:1440]
        x2 = f['/' + area + '/su/data/count'][:, 0:1440]
        x = np.vstack((x1, x2))
        del x1,x2     
    return x.T




def rescale(x):
    '''
    Rescale feature to zero mean and standard deviation 1
    '''
    mx = np.mean(x)
    sx = np.std(x)
    return (x - mx)/sx


