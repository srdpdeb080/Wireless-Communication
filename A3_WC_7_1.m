snr_true=snr^(snr/10);
sigma=sqrt(1/(2*snr_true));
farthest_point=4*sigma;
points=1000;
pdf_array=zeros(1,points);
for i=1:(2*points+1)
    j=(farthest_point/points)*(i-1-points);
    pdf_array(i)=laplacian_noise(j,snr);
end

max_val=max(pdf_array);
x_max=find(pdf_array==max_val);
pdf_array=100*(pdf_array/max_val);
%spread=(farthest_point-x_max);
laplacian_dist=zeros(1,1);
x_values=zeros(1,1);
for i=1:(2*points+1)
    if(round(pdf_array(i))>0)
        window=pdf_array(i)*ones(1,round(pdf_array(i)));
        x_window=((farthest_point/points)*(i-1-points))*ones(1,round(pdf_array(i)));
        laplacian_dist=cat(2,laplacian_dist,window);
        x_values=cat(2,x_values,x_window);
    end
end
laplacian_dist=max_val*(laplacian_dist/100);
