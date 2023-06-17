function curr_theta = fget_slope(x, const)
    
    x_grad = linspace(0,150);

    % Define the equations of the lines as functions
    s1 = @(x_grad) ((2*const.h)/const.w)*x_grad;
    s2 = @(x_grad) ((const.h/const.w)*x_grad) + const.h;
    s3 = @(x_grad) (3*const.h)+0*x_grad;
    
    % Define the gradients for the functions
    gradients1 = polyfit(x_grad,s1(x_grad),1);
    gradients2 = polyfit(x_grad,s2(x_grad),1);
    gradients3 = polyfit(x_grad,s3(x_grad),1);
    
    % Return the gradient values depending on the x
    if x < 50
        curr_theta = atand(gradients1(1,1));
    elseif (x >= 50) && (x < 100)
        curr_theta = atand(gradients2(1,1));
    elseif x >= 100
        curr_theta = atand(gradients3(1,1));
    end
end