function sigmoid(x)
{
    return 1 / (1 + Math.exp(-x));
}

function dsigmoid(x)
{
    return x * (1 - x);
}

class NeuralNetwork
{
    constructor(inp, hid, out)
    {
        this.inp = inp;
        this.hid = hid;
        this.out = out;
        this.weights_ih = new Matrix(this.hid, this.inp);
        this.weights_ho = new Matrix(this.out, this.hid);

        this.weights_ih.randomize();
        this.weights_ho.randomize();

        this.bias_h = new Matrix(this.hid, 1);
        this.bias_h.randomize();
        this.bias_o = new Matrix(this.out, 1);
        this.bias_o.randomize();

        this.learning_rate = 0.1;
    }

    feedForward(inputs)
    {
        //console.log(inputs);
        //Generating hidden output
        let hidden = Matrix.mult(this.weights_ih, Matrix.fromArray(inputs));
        hidden.add(this.bias_h);
        //activation function
        hidden.map(sigmoid);

        let outputs = Matrix.mult(this.weights_ho, hidden);
        outputs.add(this.bias_o);
        outputs.map(sigmoid);


        return outputs.toArray();
    }

    train(inputs_array, targets_array)
    {
        //console.log("trainarr: " + inputs_array + " traintar: " + targets_array);
        //Generating hidden output
        let inputs = Matrix.fromArray(inputs_array);
        let hidden = Matrix.mult(this.weights_ih, inputs);

        hidden.add(this.bias_h);
        //activation function
        hidden.map(sigmoid);

        let outputs = Matrix.mult(this.weights_ho, hidden);
        outputs.add(this.bias_o);
        outputs.map(sigmoid);

        //Convert array to Matrix Object
        let targets = Matrix.fromArray(targets_array);

        // ERROR = TARGETS - OUTPUTS
        let outputs_error = Matrix.subtract(targets, outputs);

        let gradient = Matrix.map(outputs, dsigmoid);
        gradient.mult(outputs_error);
        gradient.mult(this.learning_rate);

        let hidden_T = Matrix.transpose(hidden);
        let weight_ho_deltas = Matrix.mult(gradient, hidden_T);

        this.weights_ho.add(weight_ho_deltas);
        this.bias_o.add(gradient);

        //Calculate the hidden layers errors
        let weights_ho_transposed = Matrix.transpose(this.weights_ho);
        let hidden_errors = Matrix.mult(weights_ho_transposed, outputs_error);

        //Calculate hidden gradient
        let hidden_gradient = Matrix.map(hidden, dsigmoid);
        hidden_gradient.mult(hidden_errors);
        hidden_gradient.mult(this.learning_rate);

        //Calculate input-hidden deltas
        let inputs_T = Matrix.transpose(inputs);
        let weights_ih_deltas = Matrix.mult(hidden_gradient, inputs_T);

        this.weights_ih.add(weights_ih_deltas);
        this.bias_h.add(hidden_gradient);

    }
}
