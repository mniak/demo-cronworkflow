FROM alpine:3.14
CMD ["/app/entrypoint.sh"]
COPY . .
RUN chmod +x job.sh

CMD ["./job.sh"]