num_bit = 10;

bit = rand(1, num_bit);

bit_4out5in = round(bit)  #�|�ˤ��J

plot(bit_4out5in)

wave_bit = bit_4out5in'*ones(1, 100) #��ܧ��A�ͦ��C�C100�ӬۦP�Ʀr

wave_bit_wave = reshape(wave_bit', 1, 1000) + rand(1,1000);  #10*100��ܧ��A�令�@�C1000�ӼƦr

t = 10^-3:10^-3:1;  #�}�l�G���j�G����

figure(2);
plot(t, wave_bit_wave);  #�o�g��
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
plot(rx_bit_wave);  #�����ݡA��2�|�M��8�@��
ylim([-0.5 1.5]);





