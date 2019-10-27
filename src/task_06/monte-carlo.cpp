#include <iostream>
#include <random>
#include <cmath>
#include <chrono>

using namespace std;

int
main (void)
{
        int n;
        double alpha;
        cin >> n >> alpha;

        chrono::time_point<chrono::system_clock> start, end;
        start = chrono::system_clock::now();

        random_device                rd   {};
        mt19937                      gen  {rd()};
        normal_distribution<double>  d    {0, sqrt(0.5)};

        double sn = 0;
        for (int j = 0; j < n; ++j) {
                double f;
                double x = 1;
                for (int i = 0; i < 10; ++i) {
                        x *= d(gen);
                }
                f = pow(M_PI, 5) * exp(-1 / (128 * x * x)) / (x * x);
                sn += f;
        }
        double integral = sn / n;
        end = std::chrono::system_clock::now();

        cout << "Значение интеграла: " << integral << endl;
        cout << "Время вычислений:   " << chrono::duration_cast<chrono::microseconds> (end-start).count() / 1000000. << " s" << endl;
        return 0;
}