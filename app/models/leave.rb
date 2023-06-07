class Leave < ApplicationRecord

	enum leave_type: { casual: 0, sick: 1, Other: 2}
end
