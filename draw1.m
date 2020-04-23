%% SIMULATION OF ELECTROPERMANAENT MAGNET 
function [force]=draw1(X)
nd_t=X(1); % Thickness of NdFeB magnet
nd_h=X(2); % Height of NdFeB magnet
al_w=X(3);  % Thickness of Alnico magnet
p_h=X(4);   %Height of Pole piece
c_t=X(5);   %Case Thickness
c_h=X(6);   %Case Height
wp_w=X(7);  % Width of the workpiece
wp_h=X(8);  % Workpiece Height
    
openfemm;
newdocument(0);

mi_probdef(0, 'millimeters', 'planar', 1.e-8, 50, 30);

len_case=110+2*(nd_t+c_t);
x_st=0; y_st=0;
xmid=len_case/2;
ht_case=c_h;
case_t=c_t;
case_ht1=c_h-p_h-14;
al_t=al_w;
% %% NOIN-LINEAR B-H for Cast Alnico 5-7 (LNG56)
% b=[0
% 0.4307
% 0.7907
% 1.014
% 1.15
% 1.213
% 1.247
% 1.276
% 1.321
% ]; % B for alnico custom
% 
% h=[0
% 3000
% 5900
% 8800
% 12800
% 18000
% 26000
% 37800
% 61400
% ]; % H for alnico custom

% B-H FOR ALNICO-5
b=[0.000000
0.125610
0.308290
0.483340
0.617340
0.754990
0.844130
0.929280
0.980770
1.024670
1.046400
1.071500
1.092900
1.106800
1.124200
1.137900
1.151700
1.165200
1.175000
1.191500
1.204600
1.217700
1.227300
1.239700
1.248800
1.254400
];

h=[0.000000
253.852134
707.443722
1452.288856
2162.915677
3024.739693
3845.979200
5110.465223
6495.909002
8023.000681
9234.169798
11043.761501
12850.170105
14650.212512
16900.663407
19147.135429
21245.593353
23790.480893
26182.579688
30071.530722
33361.263396
36650.996070
39490.320255
43971.486832
47704.784332
50988.028259
];

magname='Alnico 5';


x1=xmid; y1=y_st;
x2=x_st;y2=y_st;
x3=x_st;y3=ht_case;
x4=case_t;y4=ht_case;
x5=case_t;y5=case_ht1;
x6=xmid;y6=case_ht1;

%% Boundary
mi_drawarc([-100 70; 280 70], 180, 7);
mi_drawarc([280 70; -100 70], 180, 7);
% mi_addsegment([0 -200; 0 200]);


% Define an "asymptotic boundary condition" property.  This will mimic
% an "open" solution domain

muo = pi*4.e-7;

mi_addboundprop('Asymptotic', 0, 0, 0, 0, 0, 0, 1/(muo*0.2), 0, 2);

% Apply the "Asymptotic" boundary condition to the arc defining the
% boundary of the solution region
mi_selectarcsegment(-100,70);
mi_setarcsegmentprop(7, 'Asymptotic', 0, 0);

mi_selectarcsegment(280,70);
mi_setarcsegmentprop(7, 'Asymptotic', 0, 0);


%%

X1= [x1 x2 x3 x4 x5 x6];
Y1= [y1 y2 y3 y4 y5 y6];

X2=len_case-X1;
Y2=Y1;
add_pt(X1,Y1);
add_pt(X2,Y2);

%% ALNICO THICKNESS

    
al1_x2=xmid-30+(al_t*0.5); %Since we are using centre as reference (30 and 23 are fixed)
al1_x1=al1_x2-(al_t); % 46 is the width of alnico

al1_y1=case_ht1; %Can change this later
al1_y2=case_ht1+14; %14 is the height of alnico

mi_drawrectangle(al1_x1,al1_y1,al1_x2,al1_y2);

al2_x2=len_case-al1_x2;
al2_x1=len_case-al1_x1;

al2_y1=al1_y1;
al2_y2=al1_y2;

%%

mi_drawrectangle(al2_x1,al2_y1,al2_x2,al2_y2);

ps1_x2=xmid-5; % Distance b/w poles is 60 (therefore, an offset of 5)
ps1_x1=ps1_x2-50;

ps1_y2=ht_case;
ps1_y1=al1_y2;

mi_drawrectangle(ps1_x1,ps1_y1,ps1_x2,ps1_y2);

ps2_x2=len_case-ps1_x2;
ps2_x1=len_case-ps1_x1;

ps2_y1=ps1_y1;
ps2_y2=ps1_y2;

mi_drawrectangle(ps2_x1,ps2_y1,ps2_x2,ps2_y2);

wp_x1=(len_case-wp_w)*0.5; 
wp_y1=ht_case+0.1; % 0.1mm is the air gap for now

wp_ht=wp_h;
wp_x2=len_case+(wp_w-len_case)*0.5; 
wp_y2=wp_y1+wp_ht;


mi_drawrectangle(wp_x1,wp_y1,wp_x2,wp_y2);

%% NdFeB Magnets
%yc=0.5*(ps1_y1+ps2_y2);

ndc_y2=ht_case;
ndc_y1=ndc_y2-nd_h;

ndc_x2=ps2_x2; %ps2_x2 since we used symmetry to define pole steel 2
ndc_x1=ps1_x2;

mi_drawrectangle(ndc_x1,ndc_y1,ndc_x2,ndc_y2);


ndls_y1=ndc_y1;
ndls_y2=ndc_y2;

ndls_x2=ps1_x1;
ndls_x1=case_t; % Assuming case thickness defined above as 15

mi_drawrectangle(ndls_x1,ndls_y1,ndls_x2,ndls_y2);

ndrs_y1=ndc_y1;
ndrs_y2=ndc_y2;

ndrs_x1=ps2_x1;
ndrs_x2=len_case-case_t; % Assuming case thickness defined above as 15

mi_drawrectangle(ndrs_x1,ndrs_y1,ndrs_x2,ndrs_y2);


%%
%% DATA POINTS

mi_addblocklabel(xmid,y_st+1); % For case
mi_addblocklabel(xmid-30,al1_y2-1); %For al-1
mi_addblocklabel(xmid+30,al1_y2-1); %For al-2
mi_addblocklabel(xmid-30,al1_y2+1); %For ps1
mi_addblocklabel(xmid+30,al1_y2+1); %For ps2
mi_addblocklabel(xmid, ht_case+5); %For wp
mi_addblocklabel(xmid,188);   %For air assuming 188 to be sufficiently far (Outside)
mi_addblocklabel(case_t+0.1,ndc_y1-1);   %For air
mi_addblocklabel(xmid, ndc_y1-1);   %For air
mi_addblocklabel(ndrs_x2-0.1, ndc_y1-1);   %For air
mi_addblocklabel(case_t+0.1,ndc_y1+1);% For nd_l
mi_addblocklabel(xmid, ndc_y1+1);%For nd_cen
mi_addblocklabel(ndrs_x2-0.1, ndc_y1+1);%For nd_right

%% MATERIAL DEFINITION 

mi_addmaterial('Air', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0); % AIR
mi_addmaterial('1020 Steel', 760, 760, 0, 0, 5.8, 0, 0, 1, 0, 0, 0); % AIR
% mi_addmaterial('NdFeB 52 MGOe', 1.05,1.05, 891300, 0, 0.667, 0, 0, 1, 0, 0, 0); % AIR
mi_addmaterial('NdFeB 37 MGOe', 1.048,1.048, 950000, 0, 0.667, 0, 0, 1, 0, 0, 0); % AIR

% mi_addmaterial('Cast Alnico 5(LNG44)', 1,1,54060, 0,2.1, 0, 0, 1, 0, 0, 0); % 
% mi_addmaterial('Cast Alnico 5-7 (LNG56)', 1,1,61400, 0,2.1, 0, 0, 1, 0, 0, 0); % 
mi_addmaterial('Alnico 5', 1.5,1.5,50963, 0,2.25, 0, 0, 1, 0, 0, 0); % 

%% B-H curve function 

add_bh_pt(magname,b,h)

%% ADDING MATERIAL

mi_selectlabel(xmid,188);
mi_setblockprop('Air', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(case_t+0.1,ndc_y1-1);
mi_setblockprop('Air', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid, ndc_y1-1);
mi_setblockprop('Air', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(ndrs_x2-0.1, ndc_y1-1);
mi_setblockprop('Air', 1, 1, '<None>', 0, 0, 0);
mi_clearselected


mi_selectlabel(xmid-30,al1_y2+1);
mi_setblockprop('1020 Steel', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid+30,al1_y2+1);
mi_setblockprop('1020 Steel', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid, ht_case+5);
mi_setblockprop('1020 Steel', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid,y_st+1);
mi_setblockprop('1020 Steel', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(case_t+0.1,ndc_y1+1);
mi_setblockprop('NdFeB 37 MGOe', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid, ndc_y1+1);
mi_setblockprop('NdFeB 37 MGOe', 1, 1, '<None>', 180, 0, 0);
mi_clearselected

mi_selectlabel(ndrs_x2-0.1, ndc_y1+1);
mi_setblockprop('NdFeB 37 MGOe', 1, 1, '<None>', 0, 0, 0);
mi_clearselected

mi_selectlabel(xmid-30,al1_y2-1);
mi_setblockprop(magname, 1, 1, '<None>', -90, 0, 0);
mi_clearselected

mi_selectlabel(xmid+30,al1_y2-1);
mi_setblockprop(magname, 1, 1, '<None>', 90, 0, 0);
mi_clearselected


%% SOLUTION

mi_zoomnatural

mi_saveas('epmc.fem');

mi_analyze
mi_loadsolution

% b0=mo_getb(0,0);
% disp(sprintf('Flux density at the center of the bar is %f T',b0(2)));
% 
% b1=mo_getb(0,50);
% disp(sprintf('Flux density at r=0,z=50 is %f T',b1(2)));

mo_selectblock(xmid, ht_case+5);
force=mo_blockintegral(19);
%disp(force(i));


end

%plot(al_t,abs(force))
% title('Variation of force with varying alnico thickness');
% xlabel('AlNiCo magnet thickness');
% ylabel('Absolute Force (N)');
% axis tight



%%

