double sigmoid(double x)
{
  return 1 / (1 + Math.exp(-x));  
}

double dsigmoid(double x)
{
  return x * (1 - x);  
}

double mutate(double val, double rate)
{
  if (random(1) < rate)
  {
    return val + randomGaussian() * random(0.05, 0.1);
  }
  else
  {
    return val;
  }
}

class Matrix
{
  int rows = 0, cols = 0;
  ArrayList<ArrayList<Double>> data;
  Matrix(int r, int c)
  {
    rows = r;
    cols = c;
    data = new ArrayList<ArrayList<Double>>();
    for (int i = 0; i < this.rows; i++)
    {
      this.data.add(new ArrayList<Double>());
      for (int j = 0; j < this.cols; j++)
        this.data.get(i).add((double)0);
    }   
  }
  
  Matrix fromArray(ArrayList<Double> arr)
  {
    Matrix m = new Matrix(arr.size(), 1);
    for (int i = 0; i < m.rows; i++)
    {
      for (int j = 0; j < m.cols; j++)
      {
        m.data.get(i).set(j, arr.get(i)); 
      }  
    }
    return m;
  }
  
  ArrayList<Double> toArray()
  {
    ArrayList<Double> arr = new ArrayList<Double>();
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
      {
        arr.add(data.get(i).get(j));
      }
    return arr;
  }
  
  void randomize()
  {
    for (int i = 0; i < this.rows; i++)
    {
      for (int j = 0; j < this.cols; j++)
      {
        this.data.get(i).set(j, Math.random() * 2 - 1);  
      }
    }
  }
  
  void add(Matrix n)
  {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        data.get(i).set(j, data.get(i).get(j) + n.data.get(i).get(j));
  }
  
  void add(int n)
  {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        data.get(i).set(j, data.get(i).get(j) + n);
  }
  
  Matrix subtract(Matrix a, Matrix b)
  {
    Matrix result = new Matrix(a.rows, b.cols);
    for (int i = 0; i < result.rows; i++)
    {
      for (int j = 0; j < result.cols; j++)
        result.data.get(i).set(j, a.data.get(i).get(j) - b.data.get(i).get(j));
    }
    return result;
  }
  
  Matrix multiply(Matrix a, Matrix b)
  {
    if (a.cols != b.rows)
    {
      println("WRONG ROWS AND COLS");
      return null;
    }
    Matrix result = new Matrix(a.rows, b.cols);
    for (int i = 0; i < result.rows; i++)
    {
      for (int j = 0; j < result.cols; j++)
      {
        double sum = 0;
        for (int k = 0; k < a.cols; k++)
        {
          sum += a.data.get(i).get(k) * b.data.get(k).get(j);
        }
        result.data.get(i).set(j, sum);
      }
    }
    return result;
  }
  
  void multiply(Matrix a)
  {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)  
        data.get(i).set(j, data.get(i).get(j) * a.data.get(i).get(j));;
  }
  
  void multiply(double a)
  {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        data.get(i).set(j, data.get(i).get(j) * a);
  }
  
  void mapsigmoid()
  {
    for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        this.data.get(i).set(j, sigmoid(data.get(i).get(j)));
  }
  
  void mapdsigmoid()
  {
  for (int i = 0; i < rows; i++)
      for (int j = 0; j < cols; j++)
        this.data.get(i).set(j, dsigmoid(data.get(i).get(j)));
  }
  
  Matrix mapsigmoid(Matrix a)
  {
    Matrix result = new Matrix(a.rows, a.cols);
    for (int i = 0; i < result.rows; i++)
    {
      for (int j = 0; j < result.cols; j++)
        result.data.get(i).set(j, sigmoid(a.data.get(i).get(j)));
    }
    return result;
  }
  
  Matrix mapdsigmoid(Matrix a)
  {
    Matrix result = new Matrix(a.rows, a.cols);
    for (int i = 0; i < result.rows; i++)
    {
      for (int j = 0; j < result.cols; j++)
        result.data.get(i).set(j, dsigmoid(a.data.get(i).get(j)));
    }  
    return result;
  }
  
  void mapmutate(double rate)
  {
    for (int i = 0; i < this.rows; i++)
    {
      for (int j = 0; j < this.cols; j++)
        this.data.get(i).set(j, mutate(this.data.get(i).get(j), rate));
    }
  }
  
  Matrix transpose(Matrix a)
  {
    Matrix result = new Matrix(a.rows, a.cols);
    for (int i = 0; i < result.rows; i++)
    {
      for (int j = 0; j < result.cols; j++)
        result.data.get(j).set(i, a.data.get(i).get(j));
    }
    return result;
  }
  
  Matrix copy()
  {
    Matrix result = new Matrix(rows, cols);
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        result.data.get(i).set(j, data.get(i).get(j));  
      }
    }
    return result;
  }
  
  void print()
  {
    println(data);  
  }
}
