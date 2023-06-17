function input_con = input_constraint(dim)
% Initialize vector
input_con.left = [eye(dim.Np-dim.Nc-1) zeros(dim.Np-dim.Nc-1,1)];

   for i = 1:length(input_con.left)-1
       input_con.left(i,i+1) = -1;
   end

input_con.left = [zeros(dim.Np-dim.Nc-1,dim.Nc) input_con.left; -input_con.left];
input_con.right = zeros(2*(dim.Np-dim.Nc-1),1);
end