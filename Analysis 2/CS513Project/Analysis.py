import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import OrdinalEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics
from sklearn.metrics import accuracy_score
from xgboost import XGBClassifier
import seaborn as sns
import matplotlib.pyplot as plt 
plt.rc("font", size=11)

def preprocess(df):
	cat_vars = df.columns[df.dtypes == object]
	c = cat_vars.tolist()
	c.remove('STATUS')
	c.append('REHIRE')
	c.append('JOB_SATISFACTION')
	for var in c:
		cat_list ='var'+'_'+var
		cat_list = pd.get_dummies(df[var], prefix=var)
		data1 = df.join(cat_list)
		df = data1

	data_vars = df.columns.values.tolist()
	to_keep = [i for i in data_vars if i not in c]
	to_keep.remove('TERMINATION_YEAR')
	to_keep.remove('EMP_ID')
	
	data_final = df[to_keep]
	col1 = data_final.columns.tolist()
	col1.remove('STATUS')
	col2 = 'STATUS'

	X = data_final[col1]
	y = data_final[col2]

	temp = np.array(y).reshape(-1,1)
	encoder = OrdinalEncoder()
	encoder.fit(temp)
	y = encoder.transform(temp)
	y = y.ravel()
	return X, y

def explor_plot(df, col1, col2):
	plt.figure(figsize=(12,12))
	pd.crosstab(df[col1], df[col2]).plot(kind='bar')
	plt.title('{} vs {}'.format(col1, col2));
	plt.xlabel(col1);
	plt.ylabel('Frequency');
	plt.xticks(rotation=0);
	plt.savefig('{} and {}.png'.format(col1, col2))
	plt.close()

def runlr():
	logreg = LogisticRegression(penalty="l1", solver='liblinear')
	logreg.fit(X_train, y_train)

	score = logreg.score(X_train, y_train)
	print('Accuracy of logistic regression classifier with L1 penalty on train set: {:.2f}'.format(score))

	y_pred = logreg.predict(X_test)
	score = logreg.score(X_test, y_test)
	print('Accuracy of logistic regression classifier with L1 penalty on test set: {:.2f}'.format(score))

	cm = metrics.confusion_matrix(y_test, y_pred)
	plt.figure(figsize=(6,6))
	ax = sns.heatmap(cm, annot=True, fmt=".3f", square=True, cmap='Blues_r');
	plt.ylabel('Actual label');
	plt.xlabel('Predicted label');
	ax.set_ylim([0,2])
	all_sample_title = 'Accuracy Score: {:.3f}'.format(score)
	plt.title(all_sample_title, size = 15);
	plt.savefig('cm for LR.png')
	plt.close()

def runrf(tree, d):
	clf = RandomForestClassifier(random_state=345, n_estimators=tree, max_depth = d)
	clf.fit(X_train, y_train)
	score = clf.score(X_train, y_train)
	print('Accuracy of random forest classifier on train set: {:.2f}'.format(score))

	y_pred = clf.predict(X_test)
	score = clf.score(X_test, y_test)
	print('Accuracy of random forest classifier on test set: {:.2f}'.format(score))

	cm = metrics.confusion_matrix(y_test, y_pred)
	plt.figure(figsize=(6,6))
	ax = sns.heatmap(cm, annot=True, fmt=".3f", square=True, cmap='Blues_r');
	plt.ylabel('Actual label');
	plt.xlabel('Predicted label');
	ax.set_ylim([0,2])
	all_sample_title = 'Accuracy Score: {:.3f}'.format(score)
	plt.title(all_sample_title, size = 15);
	plt.savefig('cm for RF.png')
	plt.close()

def runxgb(n_estimators, max_depth):
	model = XGBClassifier(max_depth=max_depth, n_estimators=n_estimators)
	eval_set = [(X_test, y_test)]
	model.fit(X_train, y_train, early_stopping_rounds=5, eval_metric="logloss", eval_set=eval_set, verbose=True)

	y_pred = model.predict(X_train)
	predictions = [round(value) for value in y_pred]
	accuracy = accuracy_score(y_train, predictions)
	print('Accuracy of XGBoost classifier on train set: {:.2f}'.format(accuracy))

	# make predictions for test data
	y_pred = model.predict(X_test)
	predictions = [round(value) for value in y_pred]
	# evaluate predictions
	accuracy = accuracy_score(y_test, predictions)
	print('Accuracy of XGBoost classifier on test set: {:.2f}'.format(accuracy))

if __name__ == '__main__':
	data = pd.read_csv("attrition_data.csv")
	## classes are balanced
	print(data['STATUS'].value_counts())
	explor_plot(data, 'MARITAL_STATUS', 'STATUS')

	X, y = preprocess(data)
	X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)
	
	runlr()
	runrf(200, 11)
	runxgb(200, 11)




