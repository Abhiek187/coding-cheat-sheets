function sum = recursiveSum(num)
    if num <= 0
        throw(MException("recursiveSum:illegalArgumentException", "num must be positive"))
    elseif num == 1
        sum = 1;
    else
        sum = num + recursiveSum(num - 1);
    end
end
