from flask import Flask, request

app = Flask(__name__)


@app.route('/triangle')
def index():
    try:
        a, b, c = [int(request.args.get(x)) for x in ('a', 'b', 'c')]
    except Exception as e:
        return f'invalid arguments {e}', 400
    if a == b == c:
        return 'EQUILATERAL', 200
    elif a == b or b == c or a == c:
        return 'ISOCELES', 200
    else:
        return 'SCALENE', 200


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8080)
