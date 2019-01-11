import numpy as np
from scipy.stats import pearsonr



def balancedAccuracy(TP,TN,P,N):
    '''
    Balanced accuracy of binary predictions
    
    Ranges from 0 (chance) to 1 (perfect)
    '''
    return TP/P + TN/N - 1


def pearson(x,y):
    '''
    Wrapper for Pearson correlation coefficient
    '''
    return pearsonr(x,y)