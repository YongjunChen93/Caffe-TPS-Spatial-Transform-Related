clc,clear all
tn=40;
XA=zeros(224,224,20);
X1=zeros(224,224,10);
start = 3800;
finish = 3800;
stride = 100;
% y= h5read('/tempspace/jli1/icmldata/cremi/cremi3D_A_seg_train3X3_v1_41-80.h5','/label');
% y1=permute(y,[2,3,1]);
% y2=ones(1248,1248,tn);
% y1=y2-y1;
% imshow(squeeze(y1(:,:,7)));
% F=getframe(gcf);
% imwrite(F.cdata,strcat('/tempspace/ychen7/ICML2017Model/final_model/imagecollect/label',num2str(1),'.jpg'));

% count1=1
% for q=start:stride:finish
%     f=sprintf('U_Net_cutimage10refine_%dresult/U_Net_cutI10layer%dresult',q,q);
%     mkdir(f);
%     for k=1:6
%         for j=1:6
%             for i=1:tn
%             fname=sprintf('U_Net_cutimage10refine_%dresult/U_Net_%dresultw%d_h%d/U_Net_%dresultw%d_h%d_shift_%d.h5',q,q,k,j,q,k,j,i-1);    
%             y=h5read(fname,'/data');
%             XA(:,:,(i*2-1):i*2)=y;
%             X1(:,:,i)=XA(:,:,i*2);
%             fn=sprintf('U_Net_cutimage10refine_%dresult/U_Net_cutI10layer%dresult/U_Net_cutI10layer%dresultw%dh%d.h5',q,q,q,k,j);
%             hdf5write(fn,'/data',X1);
%             end
%         end
%     end
%     count1=count1+1
% end
% count2=1
% X(1:1248,1:1248,1:tn)=0;
% for q=start:stride:finish
%    f=sprintf('U_Net_cutimage10refine%dresult/U_Net_imageconnectresult',q);
%    
%    mkdir(f);  
% for i=1:6
%     for j=1:6
%         fn=sprintf('y%d%d',i,j);
%         fname=sprintf('U_Net_cutimage10refine_%dresult/U_Net_cutI10layer%dresult/U_Net_cutI10layer%dresultw%dh%d.h5',q,q,q,i,j);        
%         %fn=sprintf('y%d%d',i,j)=h5read(fname,'/data');
%         eval(sprintf('%s=h5read(fname,''/data'');',fn)); 
%         %fn=h5read(fname,'/data');       
%     end
% end
% %%%5,6
% ww1(1:202,1:10,1:tn)=0;
% for j=1:202
%     for i=1:10
%         ww1(j,i,:)=1-0.1*(i-1);
%     end
% end
% ww7(1:180,1:10,:)=ww1(23:202,1:10,:);
% ww2(1:202,1:10,1:tn)=0;
% for j=1:202
%     for i=1:10    
%         ww2(j,i,:)=0.1*i-0.1;
%     end
% end
% ww8(1:180,1:10,:)=ww2(23:202,1:10,:);
% ww3(1:10,1:202,1:tn)=0;
% for j=1:10
%     for i=1:202
%         ww3(j,i,:)=1-0.1*(j-1);
%     end
% end
% ww4(1:10,1:202,1:tn)=0;
% for j=1:10
%     for i=1:202
%         ww4(j,i,:)=0.1*j-0.1;
%     end
% end
% ww5(1:10,1:180,:)=ww3(1:10,23:202,:);
% ww6(1:10,1:180,:)=ww4(1:10,23:202,:);
% www1(1:213,1:20,1:tn)=0;
% for j=1:213
%     for i=1:20
%         www1(j,i,:)=1-0.05*(i-1);
%     end
% end
% www2(1:213,1:20,1:tn)=0;
% for j=1:213
%     for i=1:20    
%         www2(j,i,:)=0.05*i-0.05;
%     end
% end
% www3(1:20,1:213,1:tn)=0;
% for j=1:20
%     for i=1:213
%         www3(j,i,:)=1-0.05*(j-1);
%     end
% end
% www4(1:20,1:213,1:tn)=0;
% for j=1:20
%     for i=1:213
%         www4(j,i,:)=0.05*j-0.05;
%     end
% end
% %%%1-4
% w1(1:202,1:20,1:tn)=0;
% for j=1:202
%     for i=1:20
%         w1(j,i,:)=1-0.05*(i-1);
%     end
% end
% 
% w7(1:180,1:20,:)=w1(23:202,1:20,:);
% w9(1:20,1:20,:)=w1(1:20,1:20,:);
% w2(1:202,1:20,1:tn)=0;
% for j=1:202
%     for i=1:20    
%         w2(j,i,:)=0.05*i-0.05;
%     end
% end
% 
% w8(1:180,1:20,:)=w2(23:202,1:20,:);
% w10(1:20,1:20,:)=w2(1:20,1:20,:);
% w3(1:20,1:202,1:tn)=0;
% w13=zeros(20,20,tn);
% for j=1:10
%     for i=1:20
%         w13(j,i,:)=0.05*j-0.05;
%     end
% end
% 
% for j=1:10
%     for i=1:20
%         w13(j+10,i,:)=0.05-0.05*j;
%     end
% end
% 
% for j=1:20
%     for i=1:202
%         w3(j,i,:)=1-0.05*(j-1);
%     end
% end
% w5(1:20,1:180,:)=w3(1:20,23:202,:);
% w4(1:20,1:202,1:tn)=0;
% w11(1:20,1:20,:)=w3(1:20,1:20,:);
% for j=1:20
%     for i=1:202
%         w4(j,i,:)=0.05*j-0.05;
%     end
% end
% w6(1:20,1:180,:)=w4(1:20,23:202,:);
% w12(1:20,1:20,:)=w4(1:20,1:20,:);
% 
% %%%%%%%%%%%%__________connection____________%%%%%%%%%5
% 
% %%%%%%angle(1,1)
% X(1:202,1:202,:)=y11(1:202,1:202,:);
% for j=1:202
%     for i=1:20
%         X(j,202+i,:)=y11(j,202+i,:).*w1(j,i,:)+y12(j,i+2,:).*w2(j,i,:);
%     end
% end
% 
% %%%%%(1,2)
% X(1:202,223:402,:)=y12(1:202,23:202,:);
% for j=1:202
%     for i=1:20
%         X(j,402+i,:)=y12(j,202+i,:).*w1(j,i,:)+y13(j,i+2,:).*w2(j,i,:);
%     end
% end
% %%%%%%%%(1,3)
% X(1:202,423:602,:)=y13(1:202,23:202,:);
% for j=1:202
%     for i=1:20
%         X(j,602+i,:)=y13(j,202+i,:).*w1(j,i,:)+y14(j,i+2,:).*w2(j,i,:);
%     end
% end
% %%%%%%%%%%%%(1,4)
% X(1:214,623:818,:)=y14(1:214,23:218,:);
% %%%%%%(1,5)
% X(1:214,813:1030,:)=y15(1:214,1:218,:);
% for j=1:202
%     for i=1:10
%         X(j,813+i,:)=y14(j,213+i,:).*ww1(j,i,:)+y15(j,i+1,:).*ww2(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:202
%         X(202+j,823+i,:)=y15(202+j,11+i,:).*w3(j,i,:)+y25(j+2,11+i,:).*w4(j,i,:);
%     end
% end
% % %%%%%%%(1,6)
% X(1:214,1030:1248,:)=y16(1:214,6:224,:);
% for j=1:202
%     for i=1:10
%         X(j,1025+i,:)=y15(j,213+i,:).*ww1(j,i,:)+y16(j,i+1,:).*ww2(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:213
%         X(202+j,1035+i,:)=y16(202+j,11+i,:).*www3(j,i,:)+y26(j+2,11+i,:).*www4(j,i,:);
%     end
% end
% % %(%%%%%%%2,1)
% X(223:402,1:202,:)=y21(23:202,1:202,:);
% for j=1:20
%     for i=1:202
%         X(202+j,i,:)=y11(202+j,i,:).*w3(j,i,:)+y21(2+j,i,:).*w4(j,i,:);
%     end
% end
% %%%%%%%(2,2)
% X(223:402,223:402,:)=y22(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(202+j,222+i,:)=y12(202+j,22+i,:).*w5(j,i,:)+y22(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(222+j,202+i,:)=y21(22+j,202+i,:).*w7(j,i,:)+y22(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% %%%%%%(2,3)
% X(223:402,423:602,:)=y23(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(202+j,422+i,:)=y13(202+j,22+i,:).*w5(j,i,:)+y23(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% 
% for j=1:180
%     for i=1:20
%         X(222+j,402+i,:)=y22(22+j,202+i,:).*w7(j,i,:)+y23(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% % %%%%%%(2,4)
%  X(212:414,623:818,:)=y24(12:214,23:218,:);
% for j=1:20
%     for i=1:180
%         X(202+j,622+i,:)=y14(202+j,22+i,:).*w5(j,i,:)+y24(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(222+j,602+i,:)=y23(22+j,202+i,:).*w7(j,i,:)+y24(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:10
%         X(222+j,813+i,:)=y24(22+j,213+i,:).*ww7(j,i,:)+y25(22+j,i+1,:).*ww8(j,i,:);
%     end
% end
% % % %(2,5)
% X(212:414,818:1030,:)=y25(12:214,6:218,:);
% for j=1:180
%     for i=1:10
%         X(222+j,1025+i,:)=y25(22+j,213+i,:).*ww7(j,i,:)+y26(22+j,i+1,:).*ww8(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:202
%         X(402++j,823+i,:)=y25(202+j,11+i,:).*w3(j,i,:)+y35(j+2,11+i,:).*w4(j,i,:);
%     end
% end
% %%%%%(2,6)
% X(212:414,1030:1248,:)=y26(12:214,6:224,:);
% for j=1:20
%     for i=1:213
%         X(402+j,1035+i,:)=y26(202+j,11+i,:).*www3(j,i,:)+y36(j+2,11+i,:).*www4(j,i,:);
%     end
% end
% 
% %(3,1)
% for j=1:20
%     for i=1:202
%         X(402+j,i,:)=y21(202+j,i,:).*w3(j,i,:)+y31(2+j,i,:).*w4(j,i,:);
%     end
% end
% X(423:602,1:202,:)=y31(23:202,1:202,:);
% % %%%%%%%%(3,2)
% X(423:602,223:402,:)=y32(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(402+j,222+i,:)=y22(202+j,22+i,:).*w5(j,i,:)+y32(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(422+j,202+i,:)=y31(22+j,202+i,:).*w7(j,i,:)+y32(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% % %%%%%%%%(3,3)
% X(423:602,423:602,:)=y33(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(402+j,422+i,:)=y23(202+j,22+i,:).*w5(j,i,:)+y33(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(422+j,402+i,:)=y32(22+j,202+i,:).*w7(j,i,:)+y33(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% % %%%%%%%%%(3,4)
% X(412:614,623:818,:)=y34(12:214,23:218,:);
% for j=1:20
%     for i=1:180
%         X(402+j,622+i,:)=y24(202+j,22+i,:).*w5(j,i,:)+y34(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(422+j,602+i,:)=y33(22+j,202+i,:).*w7(j,i,:)+y34(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:10
%         X(422+j,813+i,:)=y34(22+j,213+i,:).*ww7(j,i,:)+y35(22+j,i+1,:).*ww8(j,i,:);
%     end
% end
% % %(3,5)
%  X(412:614,818:1030,:)=y35(12:214,6:218,:);
% for j=1:180
% 	for i=1:10
% 		X(422+j,1025+i,:)=y35(22+j,213+i,:).*ww7(j,i,:)+y36(22+j,i+1,:).*ww8(j,i,:);
% 	end
% end
% for j=1:20
%     for i=1:202
%         X(602++j,823+i,:)=y35(202+j,11+i,:).*w3(j,i,:)+y45(j+2,11+i,:).*w4(j,i,:);
%     end
% end
% %%%?3?6?
%  X(412:614,1030:1248,:)=y36(12:214,6:224,:);
% 
% for j=1:20
%     for i=1:213
%         X(602+j,1035+i,:)=y36(202+j,11+i,:).*www3(j,i,:)+y46(j+2,11+i,:).*www4(j,i,:);
%     end
% end
% % %(4,1)
% X(623:818,1:212,:)=y41(23:218,1:212,:);
% for j=1:20
%     for i=1:202
%         X(602+j,i,:)=y31(202+j,i,:).*w3(j,i,:)+y41(2+j,i,:).*w4(j,i,:);
%     end
% end
% % %%%%%%%(4,2)
% X(623:818,212:414,:)=y42(23:218,12:214,:);
% for j=1:20
%     for i=1:180
%         X(602+j,222+i,:)=y32(202+j,22+i,:).*w5(j,i,:)+y42(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% %%%%%%%%_--------------------
% for j=1:10
%     for i=1:180
%         X(813+j,222+i,:)=y42(213+j,22+i,:).*ww5(j,i,:)+y52(1+j,22+i,:).*ww6(j,i,:);
%     end
% end
% 
% for j=1:180
%     for i=1:20
%         X(622+j,202+i,:)=y41(22+j,202+i,:).*w7(j,i,:)+y42(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% % %%%%%%%%%%%(4,3)
%  X(623:818,412:612,:)=y43(23:218,12:212,:);
% for j=1:20
%     for i=1:180
%         X(602+j,422+i,:)=y33(202+j,22+i,:).*w5(j,i,:)+y43(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% %%%%%%%%%_-------------------
% for j=1:10
%     for i=1:180
%         X(813+j,422+i,:)=y43(213+j,22+i,:).*ww5(j,i,:)+y53(1+j,22+i,:).*ww6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,402+i,:)=y42(22+j,202+i,:).*w7(j,i,:)+y43(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% % %%%%%%%%%%(4,4)
% X(612:818,612:818,:)=y44(12:218,12:218,:);
% for j=1:20
%     for i=1:180
%         X(602+j,622+i,:)=y34(202+j,22+i,:).*w5(j,i,:)+y44(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% %%%%%%%%%_------------------
% for j=1:10
%     for i=1:180
%         X(813+j,622+i,:)=y44(213+j,22+i,:).*ww5(j,i,:)+y54(1+j,22+i,:).*ww6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,602+i,:)=y43(22+j,202+i,:).*w7(j,i,:)+y44(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% for j=1:180
% 	for i=1:10
% 		X(622+j,813+i,:)=y44(22+j,213+i,:).*ww7(j,i,:)+y45(22+j,i+1,:).*ww8(j,i,:);
% 	end
% end
% % %(4,5)
%  X(612:818,818:1030,:)=y45(12:218,6:218,:);
% for j=1:180
% 	for i=1:10
% 		X(622+j,1025+i,:)=y45(22+j,213+i,:).*ww7(j,i,:)+y46(22+j,i+1,:).*ww8(j,i,:);
% 	end
% end
% 
% %%%%%?4?6?
% X(612:818,1030:1248,:)=y46(12:218,6:224,:);
% 
% % %(5,1)
% for j=1:10
%     for i=1:202
%         X(813+j,i,:)=y41(213+j,i,:).*ww3(j,i,:)+y51(1+j,i,:).*ww4(j,i,:);
%     end
% end
% % %angle(5,1)
% X(813:1030,1:214,:)=y51(1:218,1:214,:);
% 
% for j=1:10
% 	for i=1:202
% 		X(1025+j,i,:)=y51(213+j,i,:).*ww3(j,i,:)+y61(j+1,i,:).*ww4(j,i,:);
% 	end
% end
% for j=1:202
%     for i=1:20
%         X(823+j,202+i,:)=y51(11+j,202+i,:).*w1(j,i,:)+y52(11+j,i+2,:).*w2(j,i,:);
%     end
% end
% 
% %%%%(6,1)
% X(1025:1248,1:214,:)=y61(1:224,1:214,:);
% for j=1:213
%     for i=1:20
%         X(1035+j,202+i,:)=y61(11+j,202+i,:).*www1(j,i,:)+y62(11+j,i+2,:).*www2(j,i,:);
%     end
% end
% % %(5,2)
% X(813:1030,212:414,:)=y52(1:218,12:214,:);
% for j=1:10
% 	for i=1:180
% 		X(1025+j,222+i,:)=y52(213+j,22+i,:).*ww3(j,i,:)+y62(j+1,22+i,:).*ww4(j,i,:);
% 	end
% end
% for j=1:202
%     for i=1:20
%         X(823+j,402+i,:)=y52(11+j,202+i,:).*w1(j,i,:)+y53(11+j,i+2,:).*w2(j,i,:);
%     end
% end
% %%%%(6,2)
% X(1025:1248,212:414,:)=y62(1:224,12:214,:);
% for j=1:213
%     for i=1:20
%         X(1035+j,402+i,:)=y62(11+j,202+i,:).*www1(j,i,:)+y63(11+j,i+2,:).*www2(j,i,:);
%     end
% end
% % %(5,3)
%  X(813:1030,412:614,:)=y53(1:218,12:214,:);
% for j=1:10
% 	for i=1:180
% 		X(1025+j,422+i,:)=y53(213+j,22+i,:).*ww3(j,i,:)+y63(j+1,22+i,:).*ww4(j,i,:);
% 	end
% end
% for j=1:202
%     for i=1:20
%         X(823+j,602+i,:)=y53(11+j,202+i,:).*w1(j,i,:)+y54(11+j,i+2,:).*w2(j,i,:);
%     end
% end
% %%%%%%6 3
% X(1025:1248,412:614,:)=y63(1:224,12:214,:);
% for j=1:213
%     for i=1:20
%         X(1035+j,602+i,:)=y63(11+j,202+i,:).*www1(j,i,:)+y64(11+j,i+2,:).*www2(j,i,:);
%     end
% end
% % %(5,4)
% X(813:1030,612:818,:)=y54(1:218,12:218,:);
% for j=1:10
% 	for i=1:180
% 		X(1025+j,622+i,:)=y54(213+j,22+i,:).*ww3(j,i,:)+y64(j+1,22+i,:).*ww4(j,i,:);
% 	end
% end
% %%%%%%%5 5 
% X(818:1030,818:1030,:)=y55(6:218,6:218,:);
% 
% %%%%%5 6
% X(818:1030,1030:1248,:)=y56(6:218,6:224,:);
% 
% 
% 
% %%%%%6 4 
% X(1025:1248,612:818,:)=y64(1:224,12:218,:);
% 
% %%%%%6 5
% X(1030:1248,818:1030,:)=y65(6:224,6:218,:);
% 
% %%%%%%%%6 6 
% X(1030:1248,1030:1248,:)=y66(6:224,6:224,:);
% 
% % %square(1,1),(1,2),(1,3),(1,4),(1,5):
% for j=1:20
%     for i=1:20
%         X(202+j,202+i,:)=((y11(202+j,202+i,:).*w9(j,i,:)+y12(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y21(j+2,202+i,:).*w9(j,i,:)+y22(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% 
% for j=1:20
%     for i=1:20
%         X(202+j,402+i,:)=((y12(202+j,202+i,:).*w9(j,i,:)+y13(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y22(j+2,202+i,:).*w9(j,i,:)+y23(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         X(202+j,602+i,:)=((y13(202+j,202+i,:).*w9(j,i,:)+y14(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y23(j+2,202+i,:).*w9(j,i,:)+y24(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         X(402+j,202+i,:)=((y21(202+j,202+i,:).*w9(j,i,:)+y22(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y31(j+2,202+i,:).*w9(j,i,:)+y32(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
% 
%     end
% end
% for j=1:20
%     for i=1:20
%         X(402+j,402+i,:)=((y22(202+j,202+i,:).*w9(j,i,:)+y22(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y32(j+2,202+i,:).*w9(j,i,:)+y33(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         X(402+j,602+i,:)=((y23(202+j,202+i,:).*w9(j,i,:)+y24(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y33(j+2,202+i,:).*w9(j,i,:)+y34(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         X(602+j,202+i,:)=((y31(202+j,202+i,:).*w9(j,i,:)+y32(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y41(j+2,202+i,:).*w9(j,i,:)+y42(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         X(602+j,402+i,:)=((y32(202+j,202+i,:).*w9(j,i,:)+y33(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y42(j+2,202+i,:).*w9(j,i,:)+y43(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         X(602+j,602+i,:)=((y33(202+j,202+i,:).*w9(j,i,:)+y34(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y43(j+2,202+i,:).*w9(j,i,:)+y44(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% 
% fn=sprintf('U_Net_cutimage10refine%dresult/U_Net_imageconnectresult/U_Net_%dimageconnectresult.h5',q,q);
% hdf5write(fn,'/data',X)
% count2=count2+1
% end
% k=3800;
% for q=1:tn
%     fn=sprintf('U_Net_cutimage10refine%dresult/U_Net_imageconnectresult/U_Net_%dimageconnectresult.h5',k,k);
%     X=h5read(fn,'/data');
%     X1=ones(1248,1248,tn);
%     X=X1-X;
%     imshow(squeeze(X(:,:,q)));
%     F=getframe(gcf);
%     imwrite(F.cdata,strcat('/tempspace/ychen7/ICML2017Model/final_model/imagecollect/cremi_baseline_train20/',num2str(q),'.jpg'));
% end
count3=1
for k=start:stride:finish
    q=(k-start)/100+1;
    X(1:1248,1:1248,1:tn)=0;  
    fn=sprintf('U_Net_cutimage10refine%dresult/U_Net_imageconnectresult/U_Net_%dimageconnectresult.h5',k,k);
    X=h5read(fn,'/data');
   
    XX(1:1248*1248*tn)=0;
%     for i=1:1248
%     for j=1:1248
%         for k=1:tn            
%             XX((1248*tn)*(i-1)+tn*(j-1)+k)=X(i,j,k);            
%         end
%     end
%     end
    y= h5read('/tempspace/jli1/icmldata/cremi/cremi3D_A_seg_train3X3_v1_41-80.h5','/label');
    y1=permute(y,[2,3,1]);
    [re1 re2 re3]=measure(X,y1,0.9)
%     for i=1:1248
%     for j=1:1248
%         for k=1:tn
%             
%             Y4((1248*tn)*(i-1)+tn*(j-1)+k)=y1(i,j,k);
%             
%         end
%     end
%     end
%      AUC(q)=roc2(XX(:),Y4(:))
%     Z(1:1248,1:1248,1:tn)=0;
%     for i=1:1248
%     for j=1:1248
%         for k=1:tn
%             Z(i,j,k)= -((1-y1(i,j,k))*log(1-X(i,j,k))+y1(i,j,k)*log(X(i,j,k)));
%         end
%     end
% end
%     Q=sum(sum(sum(Z)));
%     Loss(q)=Q/(1248*1248*tn)

%      %accuracy  
%   for i=1:1248*1248*tn
%       if XX(i)<=0.4
%           XX(i)=0;
%       else
%           XX(i)=1;
%       end
%   end
%   for i=1:1248*1248*tn
%       ZZ(i)=abs(XX(i)-Y4(i));
%   end
%   E=sum(ZZ(:)==1);
%   Erates=E/(1248*1248*tn);
%   accuracy=1-Erates
    count3=count3+1
end
%%%%%%AUC%%%%

