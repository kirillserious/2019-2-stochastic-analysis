#include <iostream>
#include <random>
#include <cmath>
#include <chrono>

using namespace std;

int
main (void)
{
        int n;
        // double alpha;
        double quantil = 1.999; // Квантиль порядка 97,72%
        cin >> n;

        chrono::time_point<chrono::system_clock> start, end;
        start = chrono::system_clock::now();

        random_device                rd   {};
        mt19937                      gen  {rd()};
        normal_distribution<double>  d    {0, sqrt(0.5)};

        double sn = 0;
	double sigma = 0;
        for (int j = 0; j < n; ++j) {
                double f;
                double x = 1;
                for (int i = 0; i < 10; ++i) {
                        x *= d(gen);
                }
                f = pow(M_PI, 5) * exp(-1 / (128 * x * x)) / (x * x);
                sn += f;
		sigma += pow(f, 2);
        }
        double integral = sn / n;
	double error    = quantil * sqrt(sigma/n - pow(integral, 2)) / sqrt(n);
        end = std::chrono::system_clock::now();

        cout << "Значение интеграла: " << integral << endl;
	cout << "Погрешность:        " << error    << endl;
        cout << "Время вычислений:   " << chrono::duration_cast<chrono::microseconds> (end-start).count() / 1000000. << " секунд" << endl;
        return 0;
}
