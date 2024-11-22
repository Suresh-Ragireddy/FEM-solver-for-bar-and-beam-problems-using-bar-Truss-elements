function adjusted_e = choose_e(incremented_e, decremented_e,e)
    if incremented_e ~= 0 && decremented_e ~= 0
        adjusted_e = max(incremented_e, decremented_e); %here Min or Max You should Decide
    elseif incremented_e == 0
        adjusted_e = e;
    elseif decremented_e == 0
        adjusted_e = e;
    else
        error('Both incremented_e and decremented_e are zero. Cannot choose a valid e value.');
    end
end
