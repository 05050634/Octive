num_bit = 10;

bit = rand(1, num_bit);

bit_4out5in = round(bit)  #四捨五入

plot(bit_4out5in)

wave_bit = bit_4out5in'*ones(1, 100) #轉至完，生成每列100個相同數字

wave_bit_wave = reshape(wave_bit', 1, 1000) + rand(1,1000);  #10*100轉至完，改成一列1000個數字

t = 10^-3:10^-3:1;  #開始：間隔：結尾

figure(2);
plot(t, wave_bit_wave);  #發射端
ylim([-0.5 1.5]);

inv_bit = abs(wave_bit_wave-1);

%%%%%%%%%
%carriers
f1 = 10; f2 = 5;
cal1 = cos(2*pi*f1*t);
cal2 = cos(2*pi*f2*t);

figure(3);
subplot(2,1,1);
plot(t, cal1);
subplot(2,1,2);
plot(t, cal2);

%%%%%%%%%
%fsk_wave
fsk_wave = cal1.*wave_bit_wave + cal2.*inv_bit
figure(4);
subplot(2,1,1);
plot(t, wave_bit_wave);
ylim([-0.5 1.5]);
subplot(2,1,2);
plot(t, fsk_wave);

%%%%%%%%%%%%%%%%%%
%demondulation FSK
rxf1 = fsk_wave.*cal1;
rxf2 = fsk_wave.*cal2;
figure(5);
subplot(2,1,1);
plot(t, rxf1);
subplot(2,1,2);
plot(t, rxf2);

rx_2nd = rxf1 - rxf2;
figure(6);
subplot(2,1,1);
plot(t, wave_bit_wave);
ylim([-0.5 1.5]);
subplot(2,1,2);
plot(t, rx_2nd);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
total_arr_rxf1 = 1:10;
value_onehundred = 0;
j = 1;

for i = 1:1000
  if(rem(i, 100) != 0)
    value_onehundred = value_onehundred + rxf1(i);
  else
    total_arr_rxf1(j) = value_onehundred + rxf1(i);
    value_onehundred = 0;
    j = j+1;
  end
end

total_arr_rxf2 = 1:10;
value_onehundredd = 0;
j = 1;

for i = 1:1000
  if(rem(i, 100) != 0)
    value_onehundredd = value_onehundredd + rxf2(i);
  else
    total_arr_rxf2(j) = value_onehundredd + rxf2(i);
    value_onehundredd = 0;
    j = j+1;
  end
end

figure(7);
subplot(2,1,1);
plot(total_arr_rxf1);
subplot(2,1,2);
plot(total_arr_rxf2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rx_comp = total_arr_rxf1 - total_arr_rxf2;
rx_bit = rx_comp > 0
rx_bit_wave = reshape((rx_bit'*ones(1,100))', 1, 1000)

figure(8);
subplot(2,1,1);
plot(rx_bit);
ylim([-0.5 1.5]);
subplot(2,1,2);
plot(rx_bit_wave);  #接受端，圖2會和圖8一樣
ylim([-0.5 1.5]);





