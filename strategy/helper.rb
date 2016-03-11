module Strategy
	class Helper
		def self.unique_pairs(array)
			pairs = []
			for i in 0...array.count
				for j in (i+1)...array.count
					pairs << [array[i], array[j]]
				end
			end
			pairs
		end
	end
end
