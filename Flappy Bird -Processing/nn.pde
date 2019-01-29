class NeuralNetwork
{
  int inp, hid, out;
  double learning_rate = 0.1;
  Matrix weights_ih, weights_ho;
  Matrix bias_h, bias_o;
  Matrix temp;
  
  NeuralNetwork(int inp, int hid, int out)
  {
    this.inp = inp;  
    this.hid = hid;
    this.out = out;
    
    this.weights_ih = new Matrix(this.hid, this.inp);
    this.weights_ih.randomize();
    this.weights_ho = new Matrix(this.out, this.hid);
    this.weights_ho.randomize();
    
    this.bias_h = new Matrix(this.hid, 1);
    this.bias_h.randomize();
    this.bias_o = new Matrix(this.out, 1);
    this.bias_o.randomize();
  }
  
  NeuralNetwork(NeuralNetwork nn)
  {
    this.inp = nn.inp;
    this.hid = nn.hid;
    this.out = nn.out;
    
    this.weights_ih = nn.weights_ih.copy();
    this.weights_ho = nn.weights_ho.copy();
    
    this.bias_h = nn.bias_h.copy();
    this.bias_o = nn.bias_o.copy();
  }
  
  ArrayList<Double> feedForward(ArrayList<Double> inputs_array)
  {
    temp = new Matrix(inputs_array.size(), 1);
    Matrix inputs = temp.fromArray(inputs_array);
 
    temp = new Matrix(this.weights_ih.rows, inputs.cols);
    Matrix hidden = temp.multiply(this.weights_ih, inputs);
    hidden.add(this.bias_h);
    hidden.mapsigmoid();
    
    temp = new Matrix(this.weights_ho.rows, hidden.cols);
    Matrix outputs = temp.multiply(this.weights_ho, hidden);
    outputs.add(this.bias_o);
    outputs.mapsigmoid();
    return outputs.toArray();
  }
  
  NeuralNetwork copy()
  {
    return new NeuralNetwork(this);  
  }
  
  void mutate()
  {
    this.weights_ih.mapmutate(this.learning_rate);
    this.weights_ho.mapmutate(this.learning_rate);
    this.bias_h.mapmutate(this.learning_rate);
    this.bias_o.mapmutate(this.learning_rate);
  }
  
  void crossOver(NeuralNetwork partner, double rate)
  {
    for (int i = 0; i < this.weights_ih.rows; i++)
      for (int j = 0; j < this.weights_ih.cols; j++)
        if (random(1) < rate)
          this.weights_ih.data.get(i).set(j, partner.weights_ih.data.get(i).get(j));
          
    for (int i = 0; i < this.weights_ho.rows; i++)
      for (int j = 0; j < this.weights_ho.cols; j++)
        if (random(1) < rate)
          this.weights_ho.data.get(i).set(j, partner.weights_ho.data.get(i).get(j));
          
    for (int i = 0; i < this.bias_h.rows; i++)
      for (int j = 0; j < this.bias_h.cols; j++)
        if (random(1) < rate)
          this.bias_h.data.get(i).set(j, partner.bias_h.data.get(i).get(j));
          
    for (int i = 0; i < this.bias_o.rows; i++)
      for (int j = 0; j < this.bias_o.cols; j++)
        if (random(1) < rate)
          this.bias_o.data.get(i).set(j, partner.bias_o.data.get(i).get(j));
  }
}
