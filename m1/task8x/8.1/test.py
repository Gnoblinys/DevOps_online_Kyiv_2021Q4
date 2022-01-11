import unittest
import square


class square_test(unittest.TestCase):

    def test_disc_1(self):
        self.assertEqual(square.discriminant(2, 4, 2), 0)

    def test_disc_2(self):
        self.assertEqual(square.roots(0, 2, 4, 2), (0, -1.0))

    def test_disc_2(self):
        self.assertEqual(square.solv_square(2, 4, 2), 0)








if __name__ == '__main__':
    unittest.main()    
