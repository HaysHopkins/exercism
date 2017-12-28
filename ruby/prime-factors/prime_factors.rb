class PrimeFactors

  def self.for(n)
    [].tap do |factors|
      until n == 1
        (2..n).each do |div|
          if n % div == 0
            factors << div
            n /= div
            break
          end
        end
      end
    end
  end
end
