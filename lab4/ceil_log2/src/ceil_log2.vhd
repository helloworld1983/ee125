LIBRARY ieee;
USE ieee.std_logic_1164;
USE ieee.numeric_std.all;

PACKAGE lab4 IS 
	FUNCTION count_leading_zeros (x: UNSIGNED) return UNSIGNED;
	FUNCTION ceil_log2 (x: UNSIGNED) return UNSIGNED;
END PACKAGE lab4;

package body lab4 is
	FUNCTION count_leading_zeros (x : UNSIGNED) return UNSIGNED IS
		VARIABLE count : UNSIGNED(x'RANGE) := to_unsigned(0, x'LENGTH);
	BEGIN
		FOR i IN x'RANGE LOOP
			CASE x(i) IS
				WHEN '0' => count := count + 1;
				WHEN OTHERS          => EXIT;
			END CASE;
		END LOOP;
		RETURN count;
	END FUNCTION count_leading_zeros;
	
	FUNCTION ceil_log2 (x: UNSIGNED) return UNSIGNED IS
		VARIABLE temp : UNSIGNED(x'RANGE) := to_unsigned(0, x'LENGTH);
	begin 
		IF x = to_unsigned(0, x'LENGTH) THEN
			return to_unsigned(0, x'LENGTH);
		ELSE
			temp := count_leading_zeros(x - to_unsigned(1, x'LENGTH));
			return to_unsigned(x'HIGH, x'LENGTH) - temp + to_unsigned(1, x'LENGTH);
		END IF;
	end FUNCTION ceil_log2;
end lab4;