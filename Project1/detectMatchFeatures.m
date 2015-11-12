function [] = detectMatchFeatures(I1,I2,thresh)
[f1,s1]= makeFeatures(I1);
[f2,s2] = makeFeatures(I2);
featureMatcher2(f1,f2,s1,s2,I1,I2,thresh)
end