# Use the official Ruby image
FROM ruby:3.1.0

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the necessary gems, including RSpec
RUN bundle install

# Copy the rest of your application code into the container
COPY . .

# Set the default command to open a shell
CMD ["/bin/bash"]