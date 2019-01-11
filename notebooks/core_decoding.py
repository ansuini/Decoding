import numpy as np
from sklearn import preprocessing
from sklearn.svm import SVR
from sklearn.model_selection import train_test_split
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import make_scorer
from sklearn.preprocessing import StandardScaler
from time import time



from metrics import pearson
def my_scorer_continuous(y_true, y_predicted):
    return pearson(y_true,y_predicted)[0]

def computePerformance(X,y,param_grid,
                       epsilon=0.1,
                       fraction=0.8,
                       nfolds=5,
                       njobs=1,
                       nprocs=1):
    
    # define basis classifier
    clf_ = SVR(kernel='linear',epsilon=epsilon)
    # create scorer
    my_func = make_scorer(my_scorer_continuous,greater_is_better=True)
        
    # permutation of the dataset 
    nstim = X.shape[0]
    perm = np.random.permutation(nstim)
    X = X[perm,:]
    y = y[perm]
    
    # divide intro training and test
    ntest = int(np.floor(nstim*fraction))
    ntrain = nstim-ntest
    XTrain = X[:ntrain,:]
    yTrain = y[:ntrain]
    XTest = X[ntrain:]
    yTest = y[ntrain:]
    
    # scale data
    
    scXTrain = StandardScaler()
    scXTest = StandardScaler()
    scyTrain = StandardScaler()
    scyTest = StandardScaler()
    
    # reshape y to add a singleton dimension
    yTrain = np.reshape(yTrain,(-1,1))
    yTest = np.reshape(yTest,(-1,1))
    
    XTrain = scXTrain.fit_transform(XTrain)
    XTest = scXTest.fit_transform(XTest)
    yTrain = scyTrain.fit_transform(yTrain)
    yTest = scyTest.fit_transform(yTest)
               
    # reshape back
    yTrain = np.squeeze(yTrain)
    yTest = np.squeeze(yTest)
    
    # define the grid search object
    grid_search = GridSearchCV(clf_, 
                    param_grid, 
                    scoring=my_func, 
                    cv=nfolds, 
                    n_jobs=nprocs, 
                    refit=True,
                    return_train_score=True)
    #tic = time()
    grid_search.fit(XTrain, yTrain)        
    #print('Elapsed : {}'.format(time()-tic))  
    
    # final result : generalization to the test set
    clf = SVR(C=grid_search.best_params_['C'], epsilon=epsilon)
    clf.fit(XTrain,yTrain) 
    yPred = clf.predict(XTest)
   
    return clf, grid_search, yTest, yPred