clc,clear all
XA=zeros(224,224,20);
X1=zeros(224,224,10);
start=9500;
finish=9500;
  tn=80;
% count1=1
% for q=9500:100:9500
%     f=sprintf('U_Nettest_cutimage10refine_%dresult/DSN_cutI10layer%dresult',q,q);
%     mkdir(f);
%     for k=1:5
%         for j=1:5
%             for i=1:tn
%             fname=sprintf('U_Nettest_cutimage10refine_%dresult/U_Net_%dresultw%d_h%d/U_Net_%dresultw%d_h%d_shift_%d.h5',q,q,k,j,q,k,j,i-1);    
%             y=h5read(fname,'/data');
%             XA(:,:,(i*2-1):i*2)=y;
%             X1(:,:,i)=XA(:,:,i*2);
%             fn=sprintf('U_Nettest_cutimage10refine_%dresult/DSN_cutI10layer%dresult/DSN_cutI10layer%dresultw%dh%d.h5',q,q,q,k,j);
%             hdf5write(fn,'/data',X1);
%             end
%         end
%     end
%     count1=count1+1
% end
% count2=1
% X(1:1024,1:1024,1:tn)=0;
% for q=9500:100:9500
%    f=sprintf('U_Nettest_cutimage10refine%dresult/DSN_imageconnectresult',q);
%    mkdir(f);  
% for i=1:5
%     for j=1:5
%         fn=sprintf('y%d%d',i,j);
%         fname=sprintf('U_Nettest_cutimage10refine_%dresult/DSN_cutI10layer%dresult/DSN_cutI10layer%dresultw%dh%d.h5',q,q,q,i,j);
%         %fn=sprintf('y%d%d',i,j)=h5read(fname,'/data');
%         eval(sprintf('%s=h5read(fname,''/data'');',fn)); 
%         %fn=h5read(fname,'/data');
%     end
% end
% %imshow(squeeze(y12(:,:,1)));
% w1(1:202,1:20,1:tn)=0;
% for j=1:202
%     for i=1:20
%         w1(j,i,:)=1-0.05*(i-1);
%     end
% end
% w7(1:180,1:20,:)=w1(23:202,1:20,:);
% w9(1:20,1:20,:)=w1(1:20,1:20,:);
% w2(1:202,1:20,1:tn)=0;
% for j=1:202
%     for i=1:20    
%         w2(j,i,:)=0.05*i-0.05;
%     end
% end
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
% %angle(1,1)
% X(1:202,1:202,:)=y11(1:202,1:202,:);
% for j=1:202
%     for i=1:20
%         X(j,202+i,:)=y11(j,202+i,:).*w1(j,i,:)+y12(j,i+2,:).*w2(j,i,:);
%     end
% end
% %?1,2?
% X(1:202,223:402,:)=y12(1:202,23:202,:);
% for j=1:202
%     for i=1:20
%         X(j,402+i,:)=y12(j,202+i,:).*w1(j,i,:)+y13(j,i+2,:).*w2(j,i,:);
%     end
% end
% %square:
% for j=1:20
%     for i=1:20
%         X(202+j,202+i,:)=((y11(202+j,202+i,:).*w9(j,i,:)+y12(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y21(j+2,202+i,:).*w9(j,i,:)+y22(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% % for j=1:20
% %     for i=1:20
% %         X(202+j,202+i,:)=(y11(202+j,202+i,:).*w9(j,i,:)+y12(202+j,i+2,:).*w10(j,i,:)+y21(j+2,202+i,:).*w9(j,i,:)+y22(j+2,i+2,:).*w10(j,i,:)+y11(202+j,202+i,:).*w11(j,i,:)+y12(202+j,i+2,:).*w11(j,i,:)+y21(j+2,202+i,:).*w12(j,i,:)+y22(j+2,i+2,:).*w12(j,i,:))./4;
% %     end
% % end
% for j=1:20
%     for i=1:20
%         X(202+j,402+i,:)=((y12(202+j,202+i,:).*w9(j,i,:)+y13(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y22(j+2,202+i,:).*w9(j,i,:)+y23(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(202+j,602+i,:)=y23(j+2,202+i,:).*w9(j,i,:)+y24(j+2,i+2,:).*w10(j,i,:);
%         X(202+j,602+i,:)=((y13(202+j,202+i,:).*w9(j,i,:)+y14(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y23(j+2,202+i,:).*w9(j,i,:)+y24(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
% 
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(202+j,802+i,:)=y24(j+2,202+i,:).*w9(j,i,:)+y25(j+2,i+2,:).*w10(j,i,:);
%         X(202+j,802+i,:)=((y14(202+j,202+i,:).*w9(j,i,:)+y15(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y24(j+2,202+i,:).*w9(j,i,:)+y25(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
% 
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(402+j,202+i,:)=y31(j+2,202+i,:).*w9(j,i,:)+y32(j+2,i+2,:).*w10(j,i,:);
%         X(402+j,202+i,:)=((y21(202+j,202+i,:).*w9(j,i,:)+y22(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y31(j+2,202+i,:).*w9(j,i,:)+y32(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
% 
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(402+j,402+i,:)=y32(j+2,202+i,:).*w9(j,i,:)+y33(j+2,i+2,:).*w10(j,i,:);
%         X(402+j,402+i,:)=((y22(202+j,202+i,:).*w9(j,i,:)+y22(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y32(j+2,202+i,:).*w9(j,i,:)+y33(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(402+j,602+i,:)=y33(j+2,202+i,:).*w9(j,i,:)+y34(j+2,i+2,:).*w10(j,i,:);
%         X(402+j,602+i,:)=((y23(202+j,202+i,:).*w9(j,i,:)+y24(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y33(j+2,202+i,:).*w9(j,i,:)+y34(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(402+j,802+i,:)=y34(j+2,202+i,:).*w9(j,i,:)+y35(j+2,i+2,:).*w10(j,i,:);
%         X(402+j,802+i,:)=((y24(202+j,202+i,:).*w9(j,i,:)+y24(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y34(j+2,202+i,:).*w9(j,i,:)+y35(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(602+j,202+i,:)=y41(j+2,202+i,:).*w9(j,i,:)+y42(j+2,i+2,:).*w10(j,i,:);
%         X(602+j,202+i,:)=((y31(202+j,202+i,:).*w9(j,i,:)+y32(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y41(j+2,202+i,:).*w9(j,i,:)+y42(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));    
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(602+j,402+i,:)=y42(j+2,202+i,:).*w9(j,i,:)+y43(j+2,i+2,:).*w10(j,i,:);
%         X(602+j,402+i,:)=((y32(202+j,202+i,:).*w9(j,i,:)+y33(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y42(j+2,202+i,:).*w9(j,i,:)+y43(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(602+j,602+i,:)=y43(j+2,202+i,:).*w9(j,i,:)+y44(j+2,i+2,:).*w10(j,i,:);
%         X(602+j,602+i,:)=((y33(202+j,202+i,:).*w9(j,i,:)+y34(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y43(j+2,202+i,:).*w9(j,i,:)+y44(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(602+j,802+i,:)=y44(j+2,202+i,:).*w9(j,i,:)+y45(j+2,i+2,:).*w10(j,i,:);
%         X(602+j,802+i,:)=((y34(202+j,202+i,:).*w9(j,i,:)+y35(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y44(j+2,202+i,:).*w9(j,i,:)+y45(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(802+j,202+i,:)=y51(j+2,202+i,:).*w9(j,i,:)+y52(j+2,i+2,:).*w10(j,i,:);
%         X(802+j,202+i,:)=((y41(202+j,202+i,:).*w9(j,i,:)+y42(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y51(j+2,202+i,:).*w9(j,i,:)+y52(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(802+j,402+i,:)=y52(j+2,202+i,:).*w9(j,i,:)+y53(j+2,i+2,:).*w10(j,i,:);
%         X(802+j,402+i,:)=((y42(202+j,202+i,:).*w9(j,i,:)+y43(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y52(j+2,202+i,:).*w9(j,i,:)+y53(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(802+j,602+i,:)=y53(j+2,202+i,:).*w9(j,i,:)+y54(j+2,i+2,:).*w10(j,i,:);
%         X(802+j,602+i,:)=((y43(202+j,202+i,:).*w9(j,i,:)+y44(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y53(j+2,202+i,:).*w9(j,i,:)+y54(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% for j=1:20
%     for i=1:20
%         %X(802+j,802+i,:)=y54(j+2,202+i,:).*w9(j,i,:)+y55(j+2,i+2,:).*w10(j,i,:);
%         X(802+j,802+i,:)=((y44(202+j,202+i,:).*w9(j,i,:)+y45(202+j,i+2,:).*w10(j,i,:)).*w11(j,i,:)+(y54(j+2,202+i,:).*w9(j,i,:)+y55(j+2,i+2,:).*w10(j,i,:)).*w12(j,i,:));
%     end
% end
% %?2,2??2?3??2?4?
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
% 
% X(223:402,423:602,:)=y23(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(202+j,422+i,:)=y13(202+j,22+i,:).*w5(j,i,:)+y23(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(222+j,402+i,:)=y22(22+j,202+i,:).*w7(j,i,:)+y23(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% X(223:402,623:802,:)=y24(23:202,23:202,:);
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
%     for i=1:20
%         X(222+j,802+i,:)=y24(22+j,202+i,:).*w7(j,i,:)+y25(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% %?3?2??3?3??3?4?
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
% X(423:602,623:802,:)=y34(23:202,23:202,:);
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
%     for i=1:20
%         X(422+j,802+i,:)=y34(22+j,202+i,:).*w7(j,i,:)+y35(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% %?4?2??4?3??4?4?
% X(623:802,223:402,:)=y42(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(602+j,222+i,:)=y32(202+j,22+i,:).*w5(j,i,:)+y42(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:180
%         X(802+j,222+i,:)=y42(202+j,22+i,:).*w5(j,i,:)+y52(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,202+i,:)=y41(22+j,202+i,:).*w7(j,i,:)+y42(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% X(623:802,423:602,:)=y43(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(602+j,422+i,:)=y33(202+j,22+i,:).*w5(j,i,:)+y43(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:180
%         X(802+j,422+i,:)=y43(202+j,22+i,:).*w5(j,i,:)+y53(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,402+i,:)=y42(22+j,202+i,:).*w7(j,i,:)+y43(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% X(623:802,623:802,:)=y44(23:202,23:202,:);
% for j=1:20
%     for i=1:180
%         X(602+j,622+i,:)=y34(202+j,22+i,:).*w5(j,i,:)+y44(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:20
%     for i=1:180
%         X(802+j,622+i,:)=y44(202+j,22+i,:).*w5(j,i,:)+y54(2+j,22+i,:).*w6(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,602+i,:)=y43(22+j,202+i,:).*w7(j,i,:)+y44(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% for j=1:180
%     for i=1:20
%         X(622+j,802+i,:)=y44(22+j,202+i,:).*w7(j,i,:)+y45(22+j,i+2,:).*w8(j,i,:);
%     end
% end
% %(1,3)
% X(1:202,423:602,:)=y13(1:202,23:202,:);
% for j=1:202
%     for i=1:20
%         X(j,602+i,:)=y13(j,202+i,:).*w1(j,i,:)+y14(j,i+2,:).*w2(j,i,:);
%     end
% end
% %(1,4)
% X(1:202,623:802,:)=y14(1:202,23:202,:);
% %angle(1,5)
% X(1:202,823:1024,:)=y15(1:202,23:224,:);
% for j=1:202
%     for i=1:20
%         X(j,802+i,:)=y14(j,202+i,:).*w1(j,i,:)+y15(j,i+2,:).*w2(j,i,:);
%         %y14(j,202+i,:).*w1(j,i,:)+.*w2(j,i,:)
%     end
% end
% 
% %(2,1)
% for j=1:20
%     for i=1:202
%         X(202+j,i,:)=y11(202+j,i,:).*w3(j,i,:)+y21(2+j,i,:).*w4(j,i,:);
%     end
% end
% X(223:402,1:202,:)=y21(23:202,1:202,:);
% %(3,1)
% for j=1:20
%     for i=1:202
%         X(402+j,i,:)=y21(202+j,i,:).*w3(j,i,:)+y31(2+j,i,:).*w4(j,i,:);
%     end
% end
% X(423:602,1:202,:)=y31(23:202,1:202,:);
% %(4,1)
% for j=1:20
%     for i=1:202
%         X(602+j,i,:)=y31(202+j,i,:).*w3(j,i,:)+y41(2+j,i,:).*w4(j,i,:);
%     end
% end
% X(623:802,1:202,:)=y41(23:202,1:202,:);
% %(5,1)_2
% for j=1:20
%     for i=1:202
%         X(802+j,i,:)=y41(202+j,i,:).*w3(j,i,:)+y51(2+j,i,:).*w4(j,i,:);
%     end
% end
% %(1,1)_2
% for j=1:20
%     for i=1:202
%         X(202+j,822+i,:)=y15(202+j,22+i,:).*w3(j,i,:)+y25(2+j,i+22,:).*w4(j,i,:);
%     end
% end
% %(2,5)
% X(223:402,823:1024,:)=y25(23:202,23:224,:);
% for j=1:20
%     for i=1:202
%         X(402+j,822+i,:)=y25(202+j,22+i,:).*w3(j,i,:)+y35(2+j,i+22,:).*w4(j,i,:);
%     end
% end
% %(3,5)
% X(423:602,823:1024,:)=y35(23:202,23:224,:);
% for j=1:20
%     for i=1:202
%         X(602+j,822+i,:)=y35(202+j,22+i,:).*w3(j,i,:)+y45(2+j,i+22,:).*w4(j,i,:);
%     end
% end
% 
% %(4,5)
% for j=1:20
%     for i=1:202
%         X(802+j,822+i,:)=y45(202+j,22+i,:).*w3(j,i,:)+y55(2+j,i+22,:).*w4(j,i,:);
%     end
% end
% X(623:802,823:1024,:)=y45(23:202,23:224,:);
% 
% %angle(5,1)
%  X(823:1024,1:202,:)=y51(23:224,1:202,:);
% for j=1:202
%     for i=1:20
%         X(822+j,202+i,:)=y51(22+j,202+i,:).*w1(j,i,:)+y52(22+j,i+2,:).*w2(j,i,:);
%     end
% end
% %?5,2?
% X(823:1024,223:402,:)=y52(23:224,23:202,:);
% for j=1:202
%     for i=1:20
%         X(822+j,402+i,:)=y52(22+j,202+i,:).*w1(j,i,:)+y53(22+j,i+2,:).*w2(j,i,:);
%     end
% end
% %(5,3)
% X(823:1024,423:602,:)=y53(23:224,23:202,:);
% for j=1:202
%     for i=1:20
%         X(822+j,602+i,:)=y53(22+j,202+i,:).*w1(j,i,:)+y54(22+j,i+2,:).*w2(j,i,:);
%     end
% end
% %(5,4)
% X(823:1024,623:802,:)=y54(23:224,23:202,:);
% %angle(5,5)
% X(823:1024,823:1024,:)=y55(23:224,23:224,:);
% for j=1:202
%     for i=1:20
%         X(822+j,802+i,:)=y54(22+j,202+i,:).*w1(j,i,:)+y55(22+j,i+2,:).*w2(j,i,:);
%         %y14(j,202+i,:).*w1(j,i,:)+.*w2(j,i,:)
%     end
% end
% % for q=1:30
% %     F=getframe(gcf);
% %     imwrite(F.cdata,strcat('/Users/Juhn/Desktop/Rearch1/Decoder/1_31/imageconnect50000/',num2str(q),'.jpg'));
% % end
% fn=sprintf('U_Nettest_cutimage10refine%dresult/DSN_imageconnectresult/DSN_%dimageconnectresult.h5',q,q);
% hdf5write(fn,'/data',X)
% count2=count2+1
% end
count3=1
stride=100;
for k=start:stride:finish
    q=(k-start)/100+1;
    X(1:1024,1:1024,1:tn)=0;  
    fn=sprintf('U_Nettest_cutimage10refine%dresult/DSN_imageconnectresult/DSN_%dimageconnectresult.h5',k,k);
    X=h5read(fn,'/data');
   
    XX(1:1024*1024*tn)=0;
%     for i=1:1248
%     for j=1:1248
%         for k=1:tn            
%             XX((1248*tn)*(i-1)+tn*(j-1)+k)=X(i,j,k);            
%         end
%     end
%     end
    y= h5read('/tempspace/jli1/icmldata/snemi3d_21-100.h5','/label');
    y1=permute(y,[2,3,1]);
    [re1 re2 re3]=measure(X,y1,0.9)
end
% k=9500;
% for q=1:tn
%     fn=sprintf('U_Nettest_cutimage10refine%dresult/DSN_imageconnectresult/DSN_%dimageconnectresult.h5',k,k);
%     X=h5read(fn,'/data');
%     imshow(squeeze(X(:,:,q)));
%     F=getframe(gcf);
%     imwrite(F.cdata,strcat('/tempspace/ychen7/ICML2017Model/final_model/imagecollect/basemodel/',num2str(q),'.jpg'));
% end

% count3=1
% for k=9500:100:9500
%     q=(k-9500)/100+1;
%     X(1:1024,1:1024,1:tn)=0;  
%     fn=sprintf('U_Nettest_cutimage10refine%dresult/DSN_imageconnectresult/DSN_%dimageconnectresult.h5',k,k);
%     X=h5read(fn,'/data');
%    
%     XX(1:1024*1024*tn)=0;
%     for i=1:1024
%     for j=1:1024
%         for k=1:tn            
%             XX((1024*tn)*(i-1)+tn*(j-1)+k)=X(i,j,k);            
%         end
%     end
%     end
%     y= h5read('/tempspace/jli1/icmldata/snemi3d_21-100.h5','/label');
%     y1=permute(y,[2,3,1]);
% 
%     for i=1:1024
%     for j=1:1024
%         for k=1:tn
%             
%             Y4((1024*tn)*(i-1)+tn*(j-1)+k)=y1(i,j,k);
%             
%         end
%     end
%     end
%      AUC(q)=roc2(XX(:),Y4(:))
%     Z(1:1024,1:1024,1:tn)=0;
%     for i=1:1024
%     for j=1:1024
%         for k=1:tn
%             Z(i,j,k)= -((1-y1(i,j,k))*log(1-X(i,j,k))+y1(i,j,k)*log(X(i,j,k)));
%         end
%     end
% end
%     Q=sum(sum(sum(Z)));
%     Loss(q)=Q/(1024*1024*tn)
%   %accuracy  
%   for i=1:1024*1024*tn
%       if XX(i)<=0.4
%           XX(i)=0;
%       else
%           XX(i)=1;
%       end
%   end
%   for i=1:1024*1024*tn
%       ZZ(i)=abs(XX(i)-Y4(i));
%   end
%   E=sum(ZZ(:)==1);
%   Erates=E/(1024*1024*tn);
%   accuracy=1-Erates
% count3=count3 + 1
% end
%%%%%%AUC%%%%

